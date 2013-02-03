# encoding: UTF-8

前提 /^上記のユーザーでサインインしている$/ do
  user = User.order(:created_at).last
  visit '/users/sign_in'
  within('form') do
    fill_in "user_email", :with => @email
    fill_in "user_password", :with => @password
    click_button "サインイン"
  end
end

もし /^ヘッダーのサインアウトリンクをクリックする$/ do
  click_on "サインアウト"
end

ならば /^サインアウト状態になる$/ do
  page.should have_content "サインイン"
  page.should_not have_content "サインアウト"
end