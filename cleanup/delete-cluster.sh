#!/bin/bash
# クラスターを消す（eksctl delete cluster）。CloudShell では途中で
# 「get credentials: failed to refresh cached credentials」で止まることがあるため、
# 認証情報を取り直しながら、eksctl のスタックが残らなくなるまで繰り返す。
#   bash cleanup/delete-cluster.sh                 # cluster.yaml のクラスター
#   bash cleanup/delete-cluster.sh auto/cluster-auto.yaml
F=${1:-cluster.yaml}
N=$(awk '/^metadata:/{m=1} m && /^  name:/{print $2; exit}' "$F")
left() { aws cloudformation list-stacks --query "length(StackSummaries[?StackStatus!='DELETE_COMPLETE' && starts_with(StackName, 'eksctl-$N-')])"; }
for t in 1 2 3 4 5 6 7 8; do
  echo "== $t 回目 $(date +%T)  残っているスタック: $(left)"
  [ "$(left)" = "0" ] && { echo "クラスター $N の削除は完了しています"; exit 0; }
  ( eval "$(aws configure export-credentials --format env)"; timeout 300 eksctl delete cluster -f "$F" --wait )
  sleep 15
done
echo "まだ残っています。CloudFormation の画面で eksctl-$N- のスタックを確かめてください"
exit 1
