#scp -r nismaster@10.5.0.81:/home/nismaster/apache-tomcat-9.0.26.tar.gz .
if [[ ! -d "/usr/bin/tomcat9" ]]; then
 tar -xvf /root/apache-tomcat-9.0.26.tar.gz
 mv /root/apache-tomcat-9.0.26 /usr/bin/tomcat9
 echo 'export CATALINA_HOME="/usr/bin/tomcat9"' > /etc/profile.d/tomcat9.sh
 export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
 echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> /etc/profile.d/tomcat9.sh
 export JRE_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"
 echo 'export JRE_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"' >> /etc/profile.d/tomcat9.sh
 chmod +x /etc/profile.d/tomcat9.sh
 #echo """
 # add following four lines before closing </tomcat-users>
 #<role rolename=\"manager-gui\" />
 #<user username=\"manager\" password=\"scis\" roles=\"manager-gui\" />
 #<role rolename=\"admin-gui\" />
 #<user username=\"admin\" password=\"scis\" roles=\"manager-gui,admin-gui\" />
 #""" >> /usr/local/tomcat9/conf/tomcat-users.xml
 #/usr/bin/tomcat9/bin/startup.sh
 #firefox localhost:8080
 #username - manager
 #password - scis
 chmod -R 4777 /usr/bin/tomcat9/
fi
