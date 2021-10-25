#!/bin/bash

echo "[Container] Configuring database settings..."
rm /usr/local/jss/tomcat/webapps/ROOT/WEB-INF/xml/DataBase.xml
cat << EOF | tee /usr/local/jss/tomcat/webapps/ROOT/WEB-INF/xml/DataBase.xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<DataBase>
        <DataBaseType>mysql</DataBaseType>
        <DataBaseDriver>org.mariadb.jdbc.Driver</DataBaseDriver>
        <ServerName>$DATABASE_HOST</ServerName>
        <ServerPort>3306</ServerPort>
        <DataBaseName>$DATABASE_NAME</DataBaseName>
        <DataBaseUser>$DATABASE_USER</DataBaseUser>
        <DataBasePassword>$DATABASE_PASSWORD</DataBasePassword>
        <MinPoolSize>5</MinPoolSize>
        <MaxPoolSize>45</MaxPoolSize>
        <MaxIdleTimeExcessConnectionsInMinutes>1</MaxIdleTimeExcessConnectionsInMinutes>
        <MaxConnectionAgeInMinutes>5</MaxConnectionAgeInMinutes>
        <NumHelperThreads>3</NumHelperThreads>
        <InStatementBatchSize>1000</InStatementBatchSize>
        <jdbcParameters>?characterEncoding=utf8&amp;useUnicode=true&amp;jdbcCompliantTruncation=false&amp;useServerPrepStmts=true</jdbcParameters>
        <!-- Logs connections checked out for 4.5 minutes before they are closed once reaching the MaxConnectionAgeInMinutes -->
        <LeakDetectionThresholdMs>270000</LeakDetectionThresholdMs>
</DataBase>
EOF
echo "[Container] Running SQL test..."
/usr/local/jss/bin/jamf-pro server config list

echo "[Container] Starting tomcat..."
/usr/local/jss/tomcat/bin/catalina.sh run
