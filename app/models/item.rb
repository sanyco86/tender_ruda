class Item < ActiveRecord::Base
  belongs_to :tender
  belongs_to :winner_user_item, class_name: UserItem, foreign_key: :winner_id
  delegate :winner_user, to: :winner_user_item, allow_nil: true

  has_many :user_items, dependent: :destroy
  validates :name, presence: true
end
