class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :attachment, AttachmentUploader
validate :image_size_validation
  validates_presence_of :name
  validates_presence_of  :attachment

  # relations
  belongs_to    :user, inverse_of: :documents


  field :name, type: String
  private
    def image_size_validation
      errors[:attachment] << "should be less than 500KB" if attachment.size > 0.5.megabytes
    end
  # validates_presence_of :name, :user_id
end
