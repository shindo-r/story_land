# language: ja
フィーチャ: サインアップ(会員登録)できる

  ○ 未登録のユーザーはサインアップ(会員登録)ができる。
     そのためには以下の2ステップを踏む必要がある。
      Step1. サインアップ画面で必要な情報を入力し、仮登録を行う
      Step2. 仮登録後に送られたメールのリンクをクリックして、本登録を完了させる

  ○ 基本方針として、ユーザーの手間を減らすために、入力すべき情報は必要最小限にする。
     そうすることでユーザーの加入を増やすのが狙い。
     その他プロフィールに関する情報は、サインアップ・サインイン後に編集できるようにする。

  ○ サインアップに必要な情報とそれが必要な理由は以下の通り。
    - ニックネーム
        作家さんにとってペンネームになる情報。
        ユーザー間で多くの交流が発生する想定なので、その際にこの名前を使ってもらう。
        ニックネームは重複してもOK。実世界でもペンネームが同じって場合もあるしね。
    - メールアドレス
        ログイン時にユーザーIDとして用いる。(ユーザーIDは忘れやすいので個人的にはいらない)
        またメールでの確認を通した本登録にも必要。(Step2のこと)
        ユーザーIDにも使うものなので重複は不可。
    - パスワード
        ログインするのに必要だから。
    - 生年月日
        未成年か否かの判定に使う。
        未成年がR-18作品を閲覧できてはいけないので、この項目が必要になる。

  ○ その他の仕様については、各シナリオを参照。


  シナリオ: ユーザー登録完了までの流れ

    * Step1. サインアップ画面で必要な情報を入力し、仮登録を行う

      前提 メールアドレス"user@example.com"のユーザーは存在しない

      もし サインアップページに行く
      かつ 以下のように入力する:
        | 項目             | 値               |
        | ニックネーム     | ゆーざー         |
        | メールアドレス   | user@example.com |
        | パスワード       | password         |
        | パスワード(確認) | password         |
        | 生年月日         | 1984/09/26       |
      かつ 利用規約を確認する
      かつ "利用規約に同意して登録"を行う

      ならば 仮登録完了ページに遷移してること
      かつ   サインイン状態にならない
      かつ   入力したメールアドレスに確認メールが送られていること
      かつ   ユーザー情報が"仮登録"の状態でデータベースに保存されていること

    * Step2 送られたメールのリンクをクリックして、本登録を完了させる

      もし ユーザー登録確認メールのリンクをクリックする
      
      ならば 本登録完了ことが提示される
      かつ   サインイン状態になる
      かつ   ユーザー情報が"本登録"の状態でデータベースに保存されていること
