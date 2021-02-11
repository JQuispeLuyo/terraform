@REM gcloud container clusters get-credentials vg-teams --zone us-east1-d --project vg-teams
kubectl delete -f auth/1-deployment.yml
kubectl delete -f auth/2-service.yml

kubectl delete -f chats/1-deployment.yml
kubectl delete -f chats/2-service.yml

kubectl delete -f sessions/1-deployment.yml
kubectl delete -f sessions/2-service.yml

kubectl delete -f teams/1-deployment.yml
kubectl delete -f teams/2-service.yml

@REM kubectl apply -f ingress.yml