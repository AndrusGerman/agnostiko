# Variables
NAMESPACE = multi-app
REGISTRY = harbor.andrusdiaz.dev/agnostiko

.PHONY: all clean build push deploy verify logs cleanup

all: build push deploy verify

build:
	@echo "Building Docker images..."
	docker build -t $(REGISTRY)/akka-hello-world:1.0 -f dockerfiles/akka-hello-world/Dockerfile .
	docker build -t $(REGISTRY)/akka-hello-world:2.0 -f dockerfiles/akka-hello-world/Dockerfile .
	docker build -t $(REGISTRY)/java-webapp:1.0 -f dockerfiles/java-webapp/Dockerfile .

push:
	@echo "Pushing Docker images to Harbor..."
	docker push $(REGISTRY)/akka-hello-world:1.0
	docker push $(REGISTRY)/akka-hello-world:2.0
	docker push $(REGISTRY)/java-webapp:1.0

deploy:
	@echo "Deploying to Kubernetes..."
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	kubectl apply -k kubernetes/akka-hello-world
	kubectl apply -k kubernetes/java-webapp

verify:
	@echo "Verifying deployments..."
	@echo "\nChecking pods:"
	kubectl get pods -n $(NAMESPACE)
	@echo "\nChecking services:"
	kubectl get services -n $(NAMESPACE)
	@echo "\nDeployments are ready when all pods show 'Running' status"

logs:
	@echo "Showing logs for both applications..."
	@echo "\nAkka HTTP logs:"
	kubectl logs -f deployment/akka-hello-world -n $(NAMESPACE) &
	@echo "\nJava Webapp logs:"
	kubectl logs -f deployment/java-webapp -n $(NAMESPACE) &

update:
	@echo "Performing rolling update..."
	kubectl set image deployment/akka-hello-world akka-hello-world=$(REGISTRY)/akka-hello-world:2.0 -n $(NAMESPACE)
	kubectl set image deployment/java-webapp java-webapp=$(REGISTRY)/java-webapp:1.0 -n $(NAMESPACE)

rollback:
	@echo "Rolling back deployments..."
	kubectl rollout undo deployment/akka-hello-world -n $(NAMESPACE)
	kubectl rollout undo deployment/java-webapp -n $(NAMESPACE)

cleanup:
	@echo "Cleaning up resources..."
	kubectl delete namespace $(NAMESPACE)

clean: cleanup
	@echo "Removing Docker images..."
	docker rmi $(REGISTRY)/akka-hello-world:1.0 || true
	docker rmi $(REGISTRY)/akka-hello-world:2.0 || true
	docker rmi $(REGISTRY)/java-webapp:1.0 || true

help:
	@echo "Available targets:"
	@echo "  all        - Build, push and deploy everything"
	@echo "  build      - Build the Docker images"
	@echo "  push       - Push images to Harbor registry"
	@echo "  deploy     - Deploy to Kubernetes"
	@echo "  verify     - Verify the deployments"
	@echo "  logs       - Show logs for both applications"
	@echo "  update     - Perform rolling update"
	@echo "  rollback   - Rollback to previous version"
	@echo "  cleanup    - Remove Kubernetes resources"
	@echo "  clean      - Remove everything including Docker images"
	@echo "  help       - Show this help message" 