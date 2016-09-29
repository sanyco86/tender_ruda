# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  name         :string
#  quantity     :integer
#  edizm_del    :integer
#  gost         :string
#  description  :string
#  tender_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  winner_id    :integer
#  measure_unit :string           default("шт."), not null
#

class Item < ActiveRecord::Base
  belongs_to :tender
  belongs_to :winner_user_item, class_name: UserItem, foreign_key: :winner_id
  delegate :winner_user, to: :winner_user_item, allow_nil: true

  has_many :user_items, dependent: :destroy
  validates :name, presence: true
end
