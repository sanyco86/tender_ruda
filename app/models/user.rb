class User < ActiveRecord::Base
  belongs_to :category
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :user_tenders, dependent: :destroy
  has_many :user_items, through: :user_tenders

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :company, presence: true
  validates :function, presence: true
  validates :phone, presence: true
  validates :adds, presence: true
  validates :categories, presence: true
  validates :file_nds, presence: true
  validates :file_reg, presence: true

  before_validation :prepend_www

  has_attached_file :file_nds, :url => '/uploads/:class/:attachment/:id/:style/:basename.:extension', 
                               :path => ':rails_root/public/uploads/:class/:attachment/:id/:style/:basename.:extension',
                               :default_url => ''
  validates_attachment_size :file_nds, :less_than => 2.megabytes
  validates_attachment_content_type :file_nds, :content_type => %w(image/jpeg image/png application/pdf image/tiff)
  
  has_attached_file :file_reg, :url => '/uploads/:class/:attachment/:id/:style/:basename.:extension', 
                               :path => ':rails_root/public/uploads/:class/:attachment/:id/:style/:basename.:extension',
                               :default_url => ''
  validates_attachment_size :file_reg, :less_than => 2.megabytes
  validates_attachment_content_type :file_reg, :content_type => %w(image/jpeg image/png application/pdf image/tiff)

  acts_as_authentic do |c|
    c.login_field = 'email'
  end

  def activate!
    self.active = true
    save
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end

  def deliver_welcome!
    reset_perishable_token!
    Notifier.welcome(self).deliver
  end
  
  def prepend_www
    return if www.blank?
    self.www = "http://#{www}" unless www.match(/^(http|https):\/\//)
  end
end
