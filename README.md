# blue-green
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo dnf install git -y
newgrp docker
docker ps

mkdir -p ~/.docker/cli-plugins

curl -SL https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64 \
  -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version

git clone https://github.com/bestdevopsengineer/blue-green.git
cd blue-green
docker compose up -d --build

EC2_HOST =54.209.156.54
EC2_USER = ec2-user
EC2_SSH_KEY = your private key content


