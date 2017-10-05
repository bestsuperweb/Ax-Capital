class BankDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :full_name, type: String
  field :address, type: String
  field :account, type: String
  field :bank_name, type: String
  field :swift_code, type: String
  field :bank_address, type: String
  field :branch_name, type: String
  field :branch_code, type: String
  field :inter_swift_code, type: String
  field :inter_bank_name, type: String
  field :inter_bank_address, type: String

  embedded_in :transaction, inverse_of: :bank_detail

  validates_presence_of  :full_name, :address, :account, :bank_name, :swift_code, :bank_address, :branch_code, :branch_name
end
