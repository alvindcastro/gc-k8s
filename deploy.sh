docker build -t alvindecastro/multi-client:latest -t alvindecastro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvindecastro/multi-server:latest -t alvindecastro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alvindecastro/multi-worker:latest -t alvindecastro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alvindecastro/multi-client:latest
docker push alvindecastro/multi-server:latest
docker push alvindecastro/multi-worker:latest

docker push alvindecastro/multi-client:$SHA
docker push alvindecastro/multi-server:$SHA
docker push alvindecastro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alvindecastro/multi-server:$SHA
kubectl set image deployments/client-deployment client=alvindecastro/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alvindecastro/multi-worker:$SHA