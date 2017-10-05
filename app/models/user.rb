class User
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,               type: String
  field :encrypted_password,  type: String, default: ""

  ## other fields
  field :mobile,              type: String
  enum  :security_setting,    [:security_none, :security_email, :security_mobile]
  enum  :role,                [:normal_user, :sub_admin, :admin], default: :normal_user
  enum  :blocked_status,      [:un_blocked, :blocked], default: :un_blocked

  ## embedded documents
  embeds_one                    :gen_info
  accepts_nested_attributes_for :gen_info

  embeds_one                    :address
  accepts_nested_attributes_for :address

  embeds_one                    :finance
  accepts_nested_attributes_for :finance

  ## related documents
  has_many        :transactions, class_name: 'Transaction', inverse_of: :user
  has_many        :finalized_transactions, class_name: 'Transaction', inverse_of: :finalized_by
  has_many        :documents, inverse_of: :user

  ## callbacks
  before_save                 :create_embedded_models
  after_update                :send_email_on_finance_plan_change
  before_create               :generate_otp_and_send

  # otp methods
  def generate_otp_and_send(force = false)
    if self.sms_otp.nil? || force
      self.sms_otp = rand().to_s[2..5]
      self.sms_confirmation_sent_at = Time.now
      self.send_sms
    end
  end

  def send_sms
    # TODO: send OTP via SMS channel
  end

  def create_embedded_models
    self.finance ||= Finance.new(balance: Money.new(0.0))
  end

  def send_email_on_finance_plan_change
    if self.finance.finance_plan_id_changed?
      change = self.finance.finance_plan_id_change
      ContactMailer.plan_change_email(self, FinancePlan.find_by(id: change[0]),
        FinancePlan.find_by(id: change[1])).deliver_now
    end
  end

  ## validations
  validates_presence_of       :mobile
  validates_uniqueness_of     :email, :mobile, case_sensitive: false

  validates :mobile, length: { in: 9..10 }



  validates :accept_terms_of_service, acceptance: true

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## SMS Confirmation
  field :sms_otp,                  type: String
  field :sms_confirmed_at,         type: Time
  field :sms_confirmation_sent_at, type: Time

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## devise override methods
  def active_for_authentication?
    super && un_blocked?
  end

  def inactive_message
    un_blocked? ? super : "This account is blocked by admin. Please contact Site Admin for further actions."
  end

  # helper methods
  def full_name
    [gen_info.try(:first_name).try(:capitalize), gen_info.try(:last_name).try(:capitalize)].reject(&:blank?).join(' ')
  end

  def mobile_verification_complete
    return sms_confirmed_at.present?
  end

  ## profile completion logic
  def field_set?(path, null_value = nil)
    object = self
    path.split('.').each do |key|
      object = object.send(key)
      return nil if object.blank? || object == null_value
    end
    object
  end

  Check_fields = [
    { path: "email", value: 5 },
    { path: "mobile", value: 5 },
    { path: "encrypted_password", value: 5 },
    { path: "gen_info.first_name", value: 5},
    { path: "gen_info.last_name", value: 5},
    { path: "gen_info.date_of_birth", value: 5},
    { path: "gen_info.uk_resident", value: 5},
    { path: "address.address_line", value: 5},
    { path: "address.city", value: 5},
    { path: "address.state", value: 5},
    { path: "address.zip", value: 5},
    { path: "security_setting", value: 5, null_value: :security_none},
    { path: "finance.finance_plan_id", value: 5}
  ]
  def profile_completeness
    num = den = 0
    User::Check_fields.each do |field|
      den += field[:value]
      num += field[:value] if field_set?(field[:path], field[:null_value])
    end
    return (num * 100.0 / den).to_i
  end
end
