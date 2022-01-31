FROM tomcat:latest
# Dummy text to test 
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
