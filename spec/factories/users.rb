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

FactoryGirl.define do
  factory :user do
    name 'Petr Ivanov'
    sequence(:email) {|n| "user#{n}@tis.com" }
    company 'Horns&Hoofs'
    password '12345678'
    function 'a function'
    www 'http://site.localhost'
  end
end
