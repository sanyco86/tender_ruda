describe Category do
  it { should have_many(:tender_categories) }
  it { should have_many(:user_categories) }
  it { should have_many(:tenders) }
  it { should have_many(:users) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
