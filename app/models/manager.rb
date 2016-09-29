# == Schema Information
#
# Table name: managers
#
#  id                  :integer          not null, primary key
#  name                :string
#  email               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  password_digest_del :string
#  remember_token_del  :string
#  admin_del           :boolean          default(FALSE)
#  crypted_password    :string           default(""), not null
#  password_salt       :string           default(""), not null
#  persistence_token   :string           default(""), not null
#  single_access_token :string           default(""), not null
#  perishable_token    :string           default(""), not null
#  role                :string           default("read")
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string
#  last_login_ip       :string
#

class Manager < ActiveRecord::Base
  has_many :tenders

  validates :role, presence: true

  acts_as_authentic do |c|
    c.login_field = 'email'
  end
end
