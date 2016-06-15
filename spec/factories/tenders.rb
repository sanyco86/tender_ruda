FactoryGirl.define do
  factory :tender do
    manager
    name 'Канцелярские товары для бухгалтерии'
    status_id Tender::OPENED
    uslovie 'Товары качественные'
    dopuslovie 'Цены низкие'
    data_start { Time.now }
    data_end { 1.day.from_now }
    etap 1

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
