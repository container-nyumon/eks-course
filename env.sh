# 毎回の始めに読み込む（CloudShell を開き直すと変数は消えるため）
#   cd ~/eks-course && source env.sh
export AWS_REGION=ap-northeast-1
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export REGISTRY=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
export IMAGE=$REGISTRY/eks-course/hitokoto:1.0
# クラスターを作った人（自分）の kubectl のコンテキスト（クラスターがあるときだけ）
export ADMIN_CTX=$(kubectl config get-contexts -o name 2>/dev/null | grep '@eks-course\.' | head -1)
echo "準備 OK（リージョン $AWS_REGION）"
