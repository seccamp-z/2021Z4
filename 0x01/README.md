# Z4-0x01 講義の流れの理解と環境構築

## (1) 作業用Git Repositoryを用意しよう

- これからたくさんのコードを書いたり設定をしたりするので今回のseccamp用のgit repoを用意しましょう.
- 課題: github.com で public repositoryとして用意してリンクを講義に共有してください

## (2) 作業用VMにSSHログイン

- seccamp-z slackで指定のあった自分用のVMに対してloginしてください.
- エディタ等のツールやshellの設定等が必要であれば自由に変更していただいて構いません.
- loginできることを確認したあとは, slackで講師までmentionしてください
- 課題: loginできることが確認できたあとは, 作業VM上で事前課題の一つだった
  [これ](https://gist.github.com/slankdev/97f818b267ebec89a6d2a68574124523#%E6%BC%94%E7%BF%92%E8%AA%B2%E9%A1%8C-virtual-network-playground-2)
  を説いてみてください.
	- 構築するためのshell scriptを作業repoにpushし, 講師に共有してください.

## (2) TiNETの入門

- 事前課題では皆さんはnetnsを使って仮想ネットワークの構築たくさん行ったと思います.
- そこで以下のような課題を感じた人もいるのではないでしょうか.
	- もう少しシンプルにtopoの情報を書くだけでnetnsの設定をしてほしい.
	- shell scriptなので構成変更のときにコードを見渡さないと行けない, コードの品質も気になる
- そういった課題を解決してくれる仮想ネットワーク構築ツールとして, TiNET(タイネット)というものがあります.
  - repo: https://github.com/tinynetwork/tinet
	- 事前課題こ仮想ネットワークは, 以下ような設定ファイルを書くだけで簡単に構築できます.
	  - 課題: https://gist.github.com/slankdev/97f818b267ebec89a6d2a68574124523#%E6%BC%94%E7%BF%92%E8%AA%B2%E9%A1%8C-virtual-network-playground-1
		- tinet: https://github.com/tinynetwork/tinet/blob/master/examples/simple/topo2/spec.yaml
	- 作業用VMにはあらかじめTiNETのinstallが完了しています.
- 課題: tinetを使ってみよう(基本)
	- [これ](https://github.com/tinynetwork/tinet/blob/master/examples/simple/topo2/spec.yaml)
	  を実行してC1から, C4にpingが届くことを確認してみよう.
- 課題: tinetを使ってみよう(実践)
  - (1) で構築した仮想ネットワークを作ってみよう
	- spec.yaml は自身の作業用repoにpushしてそのリンクを講師に共有してください.

## (1) 講義の方針

ざっくりと以下の流れで進めます. 2,3は同時に進めて良いはずです

- 1. 受講生ごとのヒアリング
	- 30-60mim程度でアイスブレイクを含めて受講生一人+講師二人で雑談会をしましょう
	- これまでやってきたことや, seccamp期間中の目標設定をざっくりとおこないます.
- 2. BGP入門大会
  - 事前課題では基本的にはすべての経路をstatic routeとして設定しましたが,
	  ここからさきは実際のBGP softwareとして非常に有名なFRRoutingを用いてBGPの入門を行います.
	- 詳細カリキュラム
	  - 2.1. FRRoutingを用いたBGP設定とざっくりとした動作確認
		- 2.2. BGPの基礎の理解とFRRoutingを用いた詳細な動作確認
- 3. 自己学習開始
	- seccampは限られた短い期間しか用意されていないので,
	  講義だけでなく多くの自己学習とセットで進めます.
	- BGPの動作原理に関して詳細に勉強していきましょう.
- 4. BGP実装開始
  - あとは作るだけです. 早いとこここまで来てしまいましょう.
