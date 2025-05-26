FROM tomcat:8.5

# Install git and maven
RUN apt-get update && \
    apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Maven 3.6.3 (compatible with the project's plugins)
RUN wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /tmp/maven.tar.gz && \
    tar xf /tmp/maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.6.3 /opt/maven && \
    rm /tmp/maven.tar.gz

# Set Maven environment variables
ENV M2_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Clone the repository and create docker directory
RUN git clone https://github.com/sbcd90/docker-java-sample-webapp.git /tmp/app && \
    mkdir -p /tmp/app/src/main/docker

# Add war plugin to pom.xml
RUN cd /tmp/app && \
    sed -i '/<plugins>/a \
            <plugin>\
                <groupId>org.apache.maven.plugins</groupId>\
                <artifactId>maven-war-plugin</artifactId>\
                <version>3.3.2</version>\
            </plugin>' pom.xml

# Build and move the war file
RUN cd /tmp/app && \
    mvn clean install && \
    cp target/*.war src/main/docker/ && \
    cp src/main/docker/*.war /usr/local/tomcat/webapps/ROOT.war && \
    rm -rf /tmp/app

# Expose the port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"] 