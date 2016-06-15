class Category < ActiveRecord::Base
  has_many :tender_categories
  has_many :user_categories
  has_many :tenders, through: :tender_categories
  has_many :users, through: :user_categories

  validates :name, presence: true, uniqueness: true

  default_scope { order('name') }
end
