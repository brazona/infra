# rancher-server

```sh
sudo apt-get update &&  sudo apt install docker.io && y \
sudo docker run -d --name rancher-server --restart=always -v /opt/rancher:/var/lib/rancher  -p 80:80 -p 443:443 rancher/rancher:v2.4.3

sudo docker run -d --name rancher-server --restart=always -v /opt/rancher:/var/lib/rancher  -p 80:80 -p 443:443 rancher/rancher:v2.4.3
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
mkdir ~/.kube/

```
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.brazona.site --token n6gmrf2mkbf77fm4w9znfdnfn5gxszrt5jjvn5vpl2q4525r6wn9rh --ca-checksum 9775da6d0427f86dfae6d5e6fc23b81f0f6925180937bc97c93c0cb8a1c88e7b --node-name node-1-dsv --etcd --controlplane --worker

curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok

    ngrok config add-authtoken 2n5RdjSZAMynVbr6GeSc4V16nb8_3Jr5XabQaoXkA4Pi9aHBr

	sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://kube.brazona.info --token f2g7ghktls5w7xlljmz4ggd64966sk4c4zhpd8bqb5j2vrpsjqc26z --ca-checksum 7e794fed87da22b1acae8f48ad0d6d8b491ade708c8bdcaa9cce33ef54a25a7d --node-name k8s-2-dsv --etcd --controlplane --worker

https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/launch-kubernetes-with-rancher/use-new-nodes-in-an-infra-provider/create-an-amazon-ec2-cluster#example-iam-policy-with-passrole

sudo apt-get update
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu

sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.brazona.site --token x2sl4gjd4qxcg8ms999zq2ghvfhcg958vmcd956mnlnmpjshzk66m8 --ca-checksum 16352f43b4f585cb627b978394816dd3a720d234dec2e547b92f42e07f6ddb4e --node-name node-3-dsv --etcd --controlplane --worker

sudo mkdir /sys/fs/cgroup/cpu,cpuacct
sudo mount -t cgroup -o cpu,cpuacct none /sys/fs/cgroup/cpu,cpuacct

sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce=5:18.09.1~3-0~debian-buster


sudo docker container stop $(docker ps -a -q)
sudo docker container rm $(docker ps -a -q)
sudo docker container image rm $(docker image ls -a -q)
sudo docker container volume prune

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ubuntu


sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.brazona.site --token 4nr9n8f4t5klxf92kp7k7lhhw5wp8xmcr8xzhctmfjb89lgtjrmmbq --ca-checksum 8343ec1af7b735e36fa1cb95855c6438d1658d3a89b9cb1226603263702356ac --node-name node-3-dsv --etcd --controlplane --worker


#######################

docker logs  0e5bce6cd9a3 2>&1 | grep "Bootstrap Password:"
docker logs  0e5bce6cd9a3  2>&1 | grep "Bootstrap Password:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:Describe*",
                "ec2:ImportKeyPair",
                "ec2:CreateKeyPair",
                "ec2:CreateSecurityGroup",
                "ec2:CreateTags",
                "ec2:DeleteKeyPair",
                "ec2:ModifyInstanceMetadataOptions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances"
            ],
            "Resource": [
                "arn:aws:ec2:*:image/ami-*",
                "arn:aws:ec2:*:120569615928:instance/*",
                "arn:aws:ec2:*:120569615928:placement-group/*",
                "arn:aws:ec2:*:120569615928:volume/*",
                "arn:aws:ec2:*:120569615928:subnet/*",
                "arn:aws:ec2:*:120569615928:key-pair/*",
                "arn:aws:ec2:*:120569615928:network-interface/*",
                "arn:aws:ec2:*:120569615928:security-group/*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "ec2:RebootInstances",
                "ec2:TerminateInstances",
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "arn:aws:ec2:*:120569615928:instance/*"
        }
    ]
}

Login AWS CLI
rancher:mW^92n8}

Login Rancher
cezar.silva : 1srLgSNSbPSLSOgW
admin: W7X6TSvtR8862qAI

RDS
brazona: A22zGx6OQBe0bmi1BAEU
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.1/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.1/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml