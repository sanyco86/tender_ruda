class Manager < ActiveRecord::Base
  has_many :tenders

  validates :role, presence: true

  acts_as_authentic do |c|
    c.login_field = 'email'
  end
end
