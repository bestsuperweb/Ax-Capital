class Finance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :balance, type: Money
  field :account_number, type: String

  embedded_in :user, inverse_of: :finance
  belongs_to  :finance_plan

  validates_presence_of :balance
end
