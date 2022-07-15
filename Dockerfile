FROM tomcat:8.0.53
COPY target/*.war /usr/local/tomcat/webapps
