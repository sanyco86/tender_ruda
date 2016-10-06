# == Schema Information
#
# Table name: tenders
#
#  id               :integer          not null, primary key
#  name             :string
#  category_id_del  :integer
#  status_id        :integer          default(1)
#  uslovie          :string
#  dopuslovie       :string
#  data_start       :datetime
#  data_end         :datetime
#  manager_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fls_file_name    :string
#  fls_content_type :string
#  fls_file_size    :integer
#  fls_updated_at   :datetime
#  etap             :integer          default(1)
#

class Tender < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  OPENED = 1
  SUSPENDED = 2
  FINISHED = 3
  ARCHIVED = 4
  STATUS_MAP = { OPENED => 'Открыт', SUSPENDED => 'Приостановлен', FINISHED => 'Завершен', ARCHIVED => 'Архивирован' }

  has_many :tender_categories, dependent: :destroy
  has_many :categories, through: :tender_categories
  belongs_to :status
  belongs_to :manager
  has_many :user_tenders, dependent: :destroy
  has_many :user_items, through: :user_tenders, dependent: :destroy
  has_many :users, through: :user_tenders
  has_many :items, dependent: :destroy
  validates :name, presence:   true
  validates :manager_id, presence: true
  validates :categories, presence: true
  validates :data_end, presence: true
  validates :data_start, presence: true

  has_attached_file :fls, :url => '/uploads/:attachment/:id/:style/:basename.:extension',
                          :path => ':rails_root/public/uploads/:attachment/:id/:style/:basename.:extension',
                          :default_url => ''
  validates_attachment_size :fls, :less_than => 2.megabytes
  validates_attachment_content_type :fls, :content_type => %w(image/jpeg image/png application/pdf image/tiff application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

  scope :opened, -> { where(status: OPENED) }
  scope :suspended, -> { where(status: SUSPENDED) }
  scope :finished, -> { where(status: FINISHED) }
  scope :archived, -> { where(status: ARCHIVED) }
  scope :first_stage, -> { where(etap: 1) }

  def status
    STATUS_MAP[status_id] || status_id
  end

  def overdue?
    data_end < Time.zone.now
  end
end
