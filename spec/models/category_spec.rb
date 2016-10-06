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
  it { should have_many(:tenders).through(:tender_categories) }
  it { should have_many(:users).through(:user_categories) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it {expect(Category.all.to_sql).to eq Category.order(name: :asc).to_sql}
end
