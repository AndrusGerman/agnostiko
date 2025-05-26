FROM maven:3.8-openjdk-8

WORKDIR /app

# Clone the repository
RUN git clone https://github.com/matlux/akka-http-hello-world.git .

# Create settings.xml for Maven
RUN echo '<?xml version="1.0" encoding="UTF-8"?>' > settings.xml && \
    echo '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"' >> settings.xml && \
    echo '          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' >> settings.xml && \
    echo '          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0' >> settings.xml && \
    echo '                          https://maven.apache.org/xsd/settings-1.0.0.xsd">' >> settings.xml && \
    echo '    <localRepository>/usr/share/maven/ref/repository</localRepository>' >> settings.xml && \
    echo '</settings>' >> settings.xml

# Build the application
RUN mvn -s settings.xml clean package

# Expose the port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/uber-akka-http-hello-world-1.0.2-SNAPSHOT.jar"] 