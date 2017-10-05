Given(/^I am on (.+) page$/) do |page_name|
  visit path_to(page_name)
end

Then(/^I should see (.+)$/) do |text|
  expect(page).to have_content(text)
end

When(/^I follow (.+)$/) do |link|
  click_on link
end

Given(/^I am logged in$/) do
  email = "hello@world.net"
  password = "password"
  mobile = "1111122222"
  User.new(email: email, password: password, password_confirmation: password, mobile: mobile,
    confirmed_at: Time.now, confirmation_sent_at: Time.now).save!

  visit path_to('signin')
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end