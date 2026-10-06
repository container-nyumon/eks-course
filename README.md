# eks-course

Amazon EKS のハンズオンで使う設定ファイルです。AWS CloudShell で次のように取得して使います。

```bash
git clone https://github.com/container-nyumon/eks-course.git
cd eks-course
```

| フォルダ・ファイル | 使う回 | 中身 |
|---|---|---|
| `env.sh` | H3〜H8 | 毎回の始めに `source env.sh`（アカウント ID・イメージの名前などを変数に入れる） |
| `cluster.yaml` | H2・H6・H8 | クラスターの設定ファイル（eksctl の ClusterConfig） |
| `app/namespace.yaml` | H3 | アプリを置く Namespace `hitokoto` |
| `access/viewer-trust.json` | H3 | 読み取り専用のロールを、だれが引き受けられるか |
| `app/` | H4 | イメージを作る Dockerfile と、DB・掲示板のマニフェスト |
| `gateway/` | H5 | Gateway API で ALB を作るマニフェスト |
| `upgrade/` | H6 | PodDisruptionBudget と、更新中の見張りのスクリプト |
| `auto/` | H7（任意） | Auto Mode のクラスターと Ingress |
| `cleanup/delete-cluster.sh` | H7・H8 | クラスターを消す（止まっても認証情報を取り直して続ける） |
| `cleanup/check-left.sh` | H8 | 片付けの後に、費用のかかるものが残っていないか数える |

- リージョンは東京（ap-northeast-1）です。
- クラスターを動かしている間は費用がかかります。やめるときは H8 の手順で片付けてください。
