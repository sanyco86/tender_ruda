# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  name         :string
#  quantity     :integer
#  edizm_del    :integer
#  gost         :string
#  description  :string
#  tender_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  winner_id    :integer
#  measure_unit :string           default("шт."), not null
#

FactoryGirl.define do
  factory :items do
    edizm
    quantity 1
    name 'Шариковые ручки'
    gost 'ГОСТ 12/13'
    description 'Синего цвета'
  end
end
