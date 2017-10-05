require 'yaml'

module ApplicationHelper
  def get_content(path)
    File.open(Rails.root + path).read.html_safe
  end

  def get_faq(path)
    data = YAML::load(File.open(path))
    data.each_with_index do |hash, index|
      hash[:index] = index
    end
    data
  end

  def color_status(value, true_case, false_case)
    str = value ? "<span class='label label-success'> #{true_case} </span>" :
      "<span class='label label-danger'> #{false_case} </span>"
    str.html_safe
  end

  def blocked_status(value)
    str = value ? "<span class='label label-danger'> Yes </span>" :
      "<span class='label label-success'> No </span>"
    str.html_safe
  end

  def display_role(value)
    str = case value
    when :normal_user
      "<span class='label label-default'> Normal User </span>"
    when :sub_admin
      "<span class='label label-warning'> Sub Admin </span>"
    when :admin
      "<span class='label label-danger'> Admin </span>"
    else
      "Unknown"
    end
    str.html_safe
  end

  def transaction_type(value)
    str = case value
    when :add_funds
      "<span class='label label-success'> Deposit </span>"
    when :withdraw_funds
      "<span class='label label-danger'> Withdraw </span>"
    when :value_update
      "<span class='label label-info'> Update </span>"
    else
      "Unknown"
    end
    str.html_safe
  end

  def format_date(date)
    return date unless date
    return date.strftime("%d-%b-%y")
  end

  def setup_user(user)
    user.gen_info ||= GenInfo.new
    user.address ||= Address.new
    user.finance ||= Finance.new
    user
  end

  def setup_transaction(transaction)
    transaction.bank_detail ||= BankDetail.new
    transaction
  end
end
