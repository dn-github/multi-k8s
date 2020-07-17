docker build -t devnryn/multi-client:latest -t devnryn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t devnryn/multi-server:latest -t devnryn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t devnryn/multi-worker:latest -t devnryn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push devnryn/multi-client:latest
docker push devnryn/multi-server:latest
docker push devnryn/multi-worker:latest

docker push devnryn/multi-client:$SHA
docker push devnryn/multi-server:$SHA
docker push devnryn/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=devnryn/multi-server:$SHA
kubectl set image deployments/client-deployment client=devnryn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=devnryn/multi-worker:$SHA