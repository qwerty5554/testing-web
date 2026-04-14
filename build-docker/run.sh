#!/bin/sh
echo "Entrypoint sh script started"
exec java -cp "app:app/lib/*" -javaagent:/app/opentelemetry-javaagent.jar ${JAVA_OPTS} ${APPLICATIONCLASS} ${@}
