FROM tomcat:8-jdk8-temurin-focal

COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

COPY test.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
