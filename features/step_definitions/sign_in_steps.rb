# encoding: UTF-8

def hashes_of(table)
  if table.headers == ['項目', '値']
    [Hash[*table.rows.flatten]]
  else
    table.hashes
  end
end


def input_value(column, value)
  labels = all('label',text:column)
  raise "#{column} is not found" if labels.blank?
  field_id = labels.first['for']
  fields = all("##{field_id}")
  unless fields.blank?
    fields.first.set value
  else
    d = value.to_date
    select d.year.to_s,  from: "#{field_id}_1i"
    select d.month.to_s, from: "#{field_id}_2i"
    select d.day.to_s,   from: "#{field_id}_3i"
  end
end

もし /^open$/ do 
  save_and_open_page 
end

前提 /^以下のようなユーザーが登録されている:$/ do |table|
  hashes_of(table).each do |hash|
    user = build(:user)
    hash.each do |key, value|
      case key
      when 'メールアドレス'
        user.email = value
      when 'パスワード'
        user.password = value
      when '確認済'
        if value.downcase == 'yes'
          user.confirmation_token = 'hoge'
          user.confirmed_at = Date.current
          user.confirmation_sent_at = Date.current
        end
      else
        raise "#{key} is a invalid key"
      end
    end
    user.save!
  end
end
もし /^サインインページに行く$/ do
  visit new_user_session_path
end

もし /^以下のように入力して"(.*?)"する$/ do |button_name, table|
  within('form') do
    hashes_of(table).first.each do |key, value|
      input_value key, value
    end
    click_on button_name
  end
end

ならば /^サインイン状態になる$/ do
  within('.navbar') do
    page.should have_content('サインアウト')
  end
end

ならば /^サインイン状態にならない$/ do
  within('.navbar') do
    page.should have_content('サインイン')
  end
end

ならば /^入力情報が間違っているという情報が提示されること$/ do
  page.should have_content("メールアドレスまたはパスワードが一致しません")
end