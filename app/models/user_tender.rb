# == Schema Information
#
# Table name: user_tenders
#
#  id                :integer          not null, primary key
#  description       :string
#  status            :string
#  tender_id         :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class UserTender < ActiveRecord::Base
  belongs_to :tender
  belongs_to :user
  has_many :user_items, dependent: :destroy
  accepts_nested_attributes_for :user_items, :allow_destroy => true
  
  has_attached_file :file, :url => '/uploads/:class/:attachment/:id/:style/:basename.:extension', 
                               :path => ':rails_root/public/uploads/:class/:attachment/:id/:style/:basename.:extension',
                               :default_url => ''
  validates_attachment_size :file, :less_than => 2.megabytes
  validates_attachment_content_type :file, :content_type => %w(image/jpeg image/png application/pdf image/tiff)
end
