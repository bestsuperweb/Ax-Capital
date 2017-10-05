SEED = {
  user: [
    [{email: "admin@trading.com"}, {role: :admin, password: "admin1234", password_confirmation: "admin1234", mobile: "1234567890", confirmed_at: Time.now}],
    [{email: "sub_admin@trading.com"}, {role: :sub_admin, password: "subadmin1234", password_confirmation: "subadmin1234", mobile: "9876543211", confirmed_at: Time.now}],
    [{email: "user@trading.com"}, {role: :normal_user, password: "user1234", password_confirmation: "user1234", mobile: "9876543210", confirmed_at: Time.now}]
  ],
  finance_plan: [
    [{slug: "OptionA"}, {name: "Fixed Income", description: "Fixed Income plan with monthly income"}],
    [{slug: "OptionB"}, {name: "Capital Appreciation", description: "Capital Appreciation plan with long term returns"}],
    [{slug: "OptionC"}, {name: "Balanced Plan", description: "Balance Plan between growth and income"}]
  ]
}

def seed_data
  SEED.each do |model_name, value_hash_arrays|
    value_hash_arrays.each do |value_hash_array|
      instance = model_name.to_s.classify.constantize.find_or_initialize_by(value_hash_array[0])
      instance.update(value_hash_array[1])
      puts "errors: #{model_name}:#{instance.errors.messages}" unless instance.save
    end
  end
end

def chart_data
  User.all.each do |u|
    (Date.today-30..Date.today).each do |date|
      value = rand(200)+200
      t= Transaction.new(user_id: u.id, change_date: date, current_value: value)
      if t.save
        puts "#{date}: #{value}"
      else
        puts t.errors.messages
      end
    end
  end
end

def main
  seed_data
  # chart_data
end

main