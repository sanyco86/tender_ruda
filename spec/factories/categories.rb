FactoryGirl.define do
  factory :category do
    initialize_with{  Category.find_by_name(name) || new(attributes) }
  end
end
