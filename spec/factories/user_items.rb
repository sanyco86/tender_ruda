# == Schema Information
#
# Table name: user_items
#
#  id                       :integer          not null, primary key
#  price                    :decimal(, )
#  first_price              :decimal(, )
#  delivery                 :integer
#  comm                     :string
#  user_tender_id           :integer
#  item_id                  :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  selected_del             :boolean          default(FALSE)
#  first_price_second_stage :decimal(, )
#  total_price              :decimal(, )
#

FactoryGirl.define do
  factory :user_item do
    price 1.2
    delivery 30
    comm 'MyComment'
    user_tender
    item
  end
end
