JAR=target/SimpleMaven-0.0.1-SNAPSHOT.jar

java -Djava.ext.dirs=target/lib -cp $JAR com.test.Test $@
