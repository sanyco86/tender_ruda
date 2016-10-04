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

require 'rails_helper'

describe UserTender do

  it { should belong_to(:tender) }
  it { should belong_to(:user) }
  it { should have_many(:user_items).dependent(:destroy ) }
  it { should accept_nested_attributes_for(:user_items).allow_destroy(true) }

  it { should have_attached_file(:file) }
  it { should validate_attachment_content_type(:file).allowing('image/png', 'image/jpeg', 'image/tiff', 'application/pdf') }
  it { should validate_attachment_size(:file).less_than(2.megabytes) }
end
