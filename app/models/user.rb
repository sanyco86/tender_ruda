# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  crypted_password      :string           not null
#  password_salt         :string           not null
#  email                 :string           not null
#  persistence_token     :string           not null
#  single_access_token   :string           not null
#  perishable_token      :string           not null
#  created_at            :datetime
#  updated_at            :datetime
#  company               :string
#  function              :string
#  phone                 :string
#  adds                  :string
#  www                   :string
#  category_id_del       :integer
#  file_nds_file_name    :string
#  file_nds_content_type :string
#  file_nds_file_size    :integer
#  file_nds_updated_at   :datetime
#  file_reg_file_name    :string
#  file_reg_content_type :string
#  file_reg_file_size    :integer
#  file_reg_updated_at   :datetime
#  active                :boolean          default(FALSE), not null
#  login_count           :integer          default(0), not null
#  failed_login_count    :integer          default(0), not null
#  last_request_at       :datetime
#  current_login_at      :datetime
#  last_login_at         :datetime
#  current_login_ip      :string
#  last_login_ip         :string
#

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
