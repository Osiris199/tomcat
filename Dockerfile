FROM tomcat

RUN mv /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

COPY test.war /usr/local/tomcat/webapps/

COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

COPY manager.xml /usr/local/tomcat/conf/Catalina/localhost/manager.xml

#COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
