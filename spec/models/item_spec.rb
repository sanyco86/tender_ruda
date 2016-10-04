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

require 'rails_helper'

describe Item do
  it { should have_many(:user_items).dependent(:destroy) }
  it { should belong_to(:tender) }
  it { should belong_to(:winner_user_item).class_name(UserItem).with_foreign_key(:winner_id) }
  it { should validate_presence_of(:name) }
  it { should delegate_method(:winner_user).to(:winner_user_item) }
end
