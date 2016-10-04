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

FactoryGirl.define do
  factory :user_tender do
    description       'User description'
    tender
    user_id 1
  end
end
