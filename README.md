Cube JS on EKS


To install Cube JS in EKS app please install CSI driver for EFS and AWS load balancer in your EKS cluster to get started .


follow these steps for load balancer installation

download policy for load balancer

curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/install/iam_policy.json

create policy

aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

create service account

eksctl create iamserviceaccount \
--cluster=eks-cube-asad \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=<your-policy-arn> \
--override-existing-serviceaccounts \
--approve

Note: change to your policy arn

eksctl get iamserviceaccount --cluster <cluster-name> --name aws-load-balancer-controller --namespace kube-system

or 

kubectl get serviceaccount aws-load-balancer-controller --namespace kube-system

if you already have this  skip helm tool installation and adding repo part 

$ helm repo list
NAME                    URL
aws-efs-csi-driver      https://kubernetes-sigs.github.io/aws-efs-csi-driver
eks                     https://aws.github.io/eks-charts

 To install the TargetGroupBinding custom resource definitions (CRDs), run the following command:
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"


install helm chart aws load balancer run below

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
--set clusterName=eks-cube-dev \
--set serviceAccount.create=false \
--set region=us-east-1 \
--set vpcId=<your-vpc-id> \
--set serviceAccount.name=aws-load-balancer-controller \
-n kube-system

---------------------------------------

EFS CSI Download

Download the IAM policy document

curl -S https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/v1.2.0/docs/iam-policy-example.json -o iam-policy.json

Create an IAM policy


aws iam create-policy \ 
--policy-name EFSCSIControllerIAMPolicy \ 
--policy-document file://iam-policy.json 


Create a Kubernetes service account

 eksctl create iamserviceaccount  --cluster=eks-cube-test   --region=us-east-1  --namespace=kube-system  --name=efs-csi-controller-sa  --override-existing-serviceaccounts  --attach-policy-arn=arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy  --approve


verify

eksctl get iamserviceaccount --cluster eks-cube-test --name efs-csi-controller-sa --namespace kube-system

or 

kubectl get serviceaccount --namespace kube-system efs-csi-controller-sa


skip below if you already have helm repo

helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver

helm repo update

helm upgrade -i aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver \
--namespace kube-system \
--set image.repository=602401143452.dkr.ecr.us-west-2.amazonaws.com/eks/aws-efs-csi-driver \
--set controller.serviceAccount.create=false \
--set controller.serviceAccount.name=efs-csi-controller-sa


verify
kubectl get pod -n kube-system -l "app.kubernetes.io/name=aws-efs-csi-driver,app.kubernetes.io/instance=aws-efs-csi-driver"

-----------------------------------------------

Create EFS in Aws in EKS VPC
in Security Group of EFS allow EKS CIDR range

Create RDS in EKS VPC

-----------------------------------------------

clone the repo for cube js

clone below repo locally
# git clone https://github.com/haneefshaikh/cubejs_on_eks.git

go to Kube dir

edit the details in this file 06-cubestore-storage-class.yaml 
replace your EFS ID

in these files change the endpoint details of RDS 

01-cube-api-deployment.yaml
02-cube-refresh-worker-deployment.yaml

if you want , you can exclude config-map creation and get the data directly from rds

mysql -h your_rds_endpoint -u username -p < your_file.sql


open port of cube api pod's node to 4000 




