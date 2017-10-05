class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :address_line, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String

  embedded_in :user, inverse_of: :address

  # validates_presence_of   :address_line, :city, :state, :zip

  # helper methods
  def address_line2
    [city, state, zip].reject(&:blank?).join(', ')
  end
end
