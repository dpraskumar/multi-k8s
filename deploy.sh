docker build -t dpraskumar/multi-client:latest -t dpraskumar/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t dpraskumar/multi-server:latest -t dpraskumar/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t dpraskumar/multi-worker:latest -t dpraskumar/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push dpraskumar/multi-client:latest
docker push dpraskumar/multi-server:latest
docker push dpraskumar/multi-worker:latest
docker push dpraskumar/multi-client:$GIT_SHA
docker push dpraskumar/multi-server:$GIT_SHA
docker push dpraskumar/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dpraskumar/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=dpraskumar/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=dpraskumar/multi-server:$GIT_SHA