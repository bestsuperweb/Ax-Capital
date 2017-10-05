class FinancePlan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  field :name, type: String
  field :description, type: String

  validates_presence_of   :slug, :name, :description
end
