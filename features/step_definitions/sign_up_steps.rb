# encoding: UTF-8

前提 /^Step.+$/ do
end

前提 /^メールアドレス"(.*?)"のユーザーは存在しない$/ do |email|
  User.where(email:email).should be_blank
end

もし /^サインアップページに行く$/ do
  visit new_user_registration_path
end

もし /^以下のように入力する:$/ do |table|
  hashes_of(table).each do |hash|
    hash.each do |key, value|
      input_value(key, value)
    end
  end
end

もし /^利用規約を確認する$/ do
  # ポップアップをクリックすると色々めんどいので、リンクがあることだけ確認しておく。
  page.should have_selector("a",text:'利用規約')
end

もし /^"(.*?)"を行う$/ do |button_or_link|
  click_on button_or_link
end

ならば /^仮登録完了ページに遷移してること$/ do
  current_path.should == finish_inactive_sign_up_path
end

ならば /^入力したメールアドレスに確認メールが送られていること$/ do
  ActionMailer::Base.deliveries.find{ |mail|
    mail.subject == '仮登録終了のお知らせ'
  }.should_not be_blank
end

ならば /^ユーザー情報が"(.*?)"の状態でデータベースに保存されていること$/ do |state|
  user = User.order(:created_at).last
  case state
  when '仮登録'
    user.should_not be_confirmed
  when '本登録'
    user.should be_confirmed
  else
    raise "#{sate}は指定できません"
  end
end

もし /^ユーザー登録確認メールのリンクをクリックする$/ do
  mail = ActionMailer::Base.deliveries.find{ |mail|
    mail.subject == '仮登録終了のお知らせ'
  }
  visit mail.body.to_s.scan(/href=\"(.*)\"/).flatten.first
end

ならば /^本登録完了ことが提示される$/ do
  page.should have_content("本登録が完了しました")
end
