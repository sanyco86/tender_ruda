# == Schema Information
#
# Table name: tenders
#
#  id               :integer          not null, primary key
#  name             :string
#  category_id_del  :integer
#  status_id        :integer          default(1)
#  uslovie          :string
#  dopuslovie       :string
#  data_start       :datetime
#  data_end         :datetime
#  manager_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fls_file_name    :string
#  fls_content_type :string
#  fls_file_size    :integer
#  fls_updated_at   :datetime
#  etap             :integer          default(1)
#

FactoryGirl.define do
  factory :tender do
    manager_id { create(:manager).id }
    name 'Канцелярские товары для бухгалтерии'
    status_id Tender::OPENED
    uslovie 'Товары качественные'
    dopuslovie 'Цены низкие'
    data_start { Time.zone.now }
    data_end { 1.day.from_now }
    etap 1
    category_ids { create(:category).id }

    trait :suspended do
      status_id Tender::SUSPENDED
    end

    trait :finished do
      status_id Tender::FINISHED
    end

    trait :archived do
      status_id Tender::ARCHIVED
    end
  end
end
