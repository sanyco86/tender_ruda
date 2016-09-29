# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Category do
  it { should have_many(:tender_categories) }
  it { should have_many(:user_categories) }
  it { should have_many(:tenders) }
  it { should have_many(:users) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
