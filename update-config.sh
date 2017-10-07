#!/bin/bash -e

script_dir=$(cd $(dirname "$0"); pwd)
token_file=/tmp/.api-token

if [ ! -f $script_dir/jenkins-cli.jar ]; then
    curl -o $script_dir/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar
fi

echo "Updating Jenkins Configuration"
java -jar $script_dir/jenkins-cli.jar \
    -s http://localhost:8080/ \
    -auth "$(cat $token_file)" \
    groovy = < /var/jenkins_home/init.groovy.d/JenkinsConfigLoader.groovy
echo "Jenkins Configuration Updated"
