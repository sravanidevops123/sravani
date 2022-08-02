FROM maven as maven
RUN mkdir /usr/src/mymaven
WORKDIR /usr/src/mymaven
COPY . .
RUN mvn package -DskipTests

FROM tomcat 
WORKDIR webapps 
COPY --from=maven /usr/src/mymaven/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
