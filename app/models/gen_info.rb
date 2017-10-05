class GenInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :date_of_birth, type: Date
  field :uk_resident, type: Mongoid::Boolean, default: false

  embedded_in :user, inverse_of: :gen_info

  # validates_presence_of   :first_name, :last_name, :date_of_birth, :uk_resident
end
