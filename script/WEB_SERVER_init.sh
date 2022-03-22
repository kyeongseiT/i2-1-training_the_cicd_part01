#!/bin/bash
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)

# Timezone 변경 
sudo timedatectl set-timezone Asia/Seoul

sudo yum install -y httpd 
echo "<strong> Code Series CI/CD TEST </strong><br>" > /var/www/html/index.html
echo $INSTANCE_ID >> /var/www/html/index.html
echo $HOSTNAME >> /var/www/html/index.html
chown apache:apache /var/www/html/index.html

systemctl start httpd
systemctl enable httpd

# Set the Java & spring boot environtment 
sudo yum install -y java-1.8.0-openjdk-devel.x86_64 git
git clone https://github.com/blueice123/spring-boot-helloworld.git 
cd /spring-boot-helloworld/
sudo ./gradlew build
sudo nohup java -jar -Dserver.port=8080 ./build/libs/spring-boot-helloworld-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
# sudo nohup java -jar -Dserver.port=8080 /home/ec2-user/spring-boot-helloworld/build/libs/spring-boot-helloworld-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &

# 추후 배포 때 사용하기 위해 미리 디렉터리 생성
sudo mkdir /spring-boot-helloworld/

## Install the CodeDeploy agent 
# sudo yum -y update 
# sudo yum -y install ruby wget 
# sudo wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
# sudo chmod 700 ./install
# sudo ./install auto
# sudo systemctl start codedeploy-agent
# sudo systemctl enable codedeploy-agent

# 소스 변경해야될 리스트들 
# /root/spring-boot-helloworld/src/main/java/com/example/HelloworldController.java
# /root/spring-boot-helloworld/src/test-integration/java/com/example/HelloworldIT.java
# /root/spring-boot-helloworld/src/test/java/com/example/HelloworldControllerTest.java