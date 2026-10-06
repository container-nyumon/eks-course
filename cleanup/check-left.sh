#!/bin/bash
# 片付けの後に、費用がかかるものが残っていないか数える（すべて 0 なら片付け完了）
# ※ このコース以外で使っているものがあれば、その数も入る
R=${AWS_REGION:-ap-northeast-1}
row() { printf '%4s  %s\n' "$2" "$1"; }   # 数・名前の順（日本語の幅がずれないように）
echo "リージョン: $R"
row "EKS クラスター"            "$(aws eks list-clusters --region $R --query 'length(clusters)')"
row "EC2 インスタンス"          "$(aws ec2 describe-instances --region $R --filters Name=instance-state-name,Values=pending,running,stopping,stopped --query 'length(Reservations[].Instances[])')"
row "ロードバランサー"          "$(aws elbv2 describe-load-balancers --region $R --query 'length(LoadBalancers)')"
row "EBS（どこにもつながっていない）" "$(aws ec2 describe-volumes --region $R --filters Name=status,Values=available --query 'length(Volumes)')"
row "NAT ゲートウェイ"          "$(aws ec2 describe-nat-gateways --region $R --filter Name=state,Values=pending,available --query 'length(NatGateways)')"
row "Elastic IP"                "$(aws ec2 describe-addresses --region $R --query 'length(Addresses)')"
row "VPC（既定の VPC 以外）"    "$(aws ec2 describe-vpcs --region $R --filters Name=is-default,Values=false --query 'length(Vpcs)')"
row "CloudFormation（eksctl-）" "$(aws cloudformation list-stacks --region $R --query "length(StackSummaries[?StackStatus!='DELETE_COMPLETE' && starts_with(StackName, 'eksctl-')])")"
row "ECR（eks-course/）"        "$(aws ecr describe-repositories --region $R --query "length(repositories[?starts_with(repositoryName, 'eks-course/')])" 2>/dev/null || echo 0)"
row "IAM ポリシー（EKSCourse）" "$(aws iam list-policies --scope Local --query "length(Policies[?starts_with(PolicyName, 'EKSCourse')])")"
row "IAM ロール（eks-course-）" "$(aws iam list-roles --query "length(Roles[?starts_with(RoleName, 'eks-course-')])")"
