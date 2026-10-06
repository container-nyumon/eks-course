#!/bin/bash
# ALB 経由で /health を2秒ごとに呼び、時刻と結果（HTTP の番号）を1行ずつ書く
#   nohup bash upgrade/watch.sh > watch.log 2>&1 &
HOST=$(kubectl get gateway web -n hitokoto -o jsonpath='{.status.addresses[0].value}')
echo "見張る URL: http://$HOST/health"
while true; do
  echo "$(date +%T) $(curl -s -o /dev/null -m 3 -w '%{http_code}' "http://$HOST/health")"
  sleep 2
done
