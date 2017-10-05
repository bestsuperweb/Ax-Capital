class Transaction
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps

  field :prev_value, type: Money
  field :current_value, type: Money
  field :change_value, type: Money
  field :user_notes, type: String
  field :change_date, type: DateTime

  enum  :status,  [:status_intialized, :status_approved, :status_rejected, :status_not_required]
  enum  :mode,    [:add_funds, :withdraw_funds, :value_update]

  belongs_to  :user, class_name: "User", inverse_of: :transactions
  belongs_to  :finalized_by, class_name: "User", inverse_of: :finalized_transactions

  embeds_one                      :bank_detail
  accepts_nested_attributes_for   :bank_detail, reject_if: :all_blank

  validates_acceptance_of   :accept_terms_and_conditions, if: :withdraw_funds?

  validates_presence_of     :user_id
  validate                  :custom_validation

  def custom_validation
    # TODO: finish custom validation
  end
end
