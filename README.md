Once K8s master node setup is ready then run below commands for Magento 2 setup


This file create pods and services to help database synchronization.

kubectl apply -f etcd-cluster-rc-svc.yml


Create PV and PVC for DB pods.

kubectl apply -f mysql-pv-pvc.yml



Create DB Pod with 3 replicas and service.

kubectl apply -f mysql-db.yml



Create Web pod, PV, PVC and service.

kubectl apply -f magento-m2.yaml
