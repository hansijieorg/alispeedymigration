
if [ ! -n "$1" ] ;then
    echo "You have not input your sequence number, please run like: ./create-src.sh 1"
    exit;
fi

echo "######## create source environment on ACK########"
cp ./2048-namespace.yaml.template /tmp/2048-namespace.yaml
cp ./2048-service.yaml.template /tmp/2048-service.yaml
cp ./2048-deployment.yaml.template /tmp/2048-deployment.yaml

sed -i "s/<seq>/$1/g" /tmp/2048-namespace.yaml
sed -i "s/<seq>/$1/g" /tmp/2048-service.yaml
sed -i "s/<seq>/$1/g" /tmp/2048-deployment.yaml

kubectl apply -f /tmp/2048-namespace.yaml
kubectl apply -f /tmp/2048-service.yaml
kubectl apply -f /tmp/2048-deployment.yaml

kubectl expose deployment deployment-2048 --port=80 --target-port=80 --type=LoadBalancer -n 2048-game$1

