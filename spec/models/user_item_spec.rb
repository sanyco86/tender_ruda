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

require 'rails_helper'

describe UserItem do

  let!(:user_item) { create :user_item }

  it { should belong_to(:user_tender) }
  it { should belong_to(:item) }
  it { should delegate_method(:user).to :user_tender  }
  it { should delegate_method(:user_id).to :user_tender  }
  it { should validate_numericality_of(:price).is_greater_than(0).allow_nil }
  it { should validate_numericality_of(:delivery).is_greater_than(0).allow_nil }

  context 'when delivery is presence' do
    before do
      subject.delivery = 10
    end
    it { should validate_presence_of(:price) }
  end
  context 'when delivery is blank' do
    before do
      subject.delivery = nil
    end
    it { should_not validate_presence_of(:price) }
  end

  context 'when price is presence' do
    before do
      subject.price = 10
    end
    it { should validate_presence_of(:delivery) }
  end
  context 'when price is blank' do
    before do
      subject.price = nil
    end
    it { should_not validate_presence_of(:delivery) }
  end

  context 'scope user_item with_price' do
    let!(:user_item_with_price) { create :user_item }
    before { user_item.update(price: nil, delivery: nil) }

    it { expect(UserItem.with_price).to_not match_array user_item }
    it { expect(UserItem.with_price).to match_array user_item_with_price }
  end

  context 'first_price_save' do
    it { expect(user_item.first_price).to eq user_item.price }
  end

  context 'first_price_second_stage_update' do
    before do
      user_item.user_tender.tender.update(etap: 2)
      user_item.update(price: 100)
    end

    it { expect(user_item.first_price_second_stage).to eq 100 }
  end

  context 'total_price_save' do
    it { expect(user_item.total_price).to eq user_item.price * user_item.item.quantity }
  end

  context 'price sub , to.' do
    before { user_item.update(price: '10,9') }
    it { expect(user_item.price).to eq 10.9 }
  end
end
