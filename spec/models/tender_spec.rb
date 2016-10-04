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

require 'rails_helper'

describe Tender do

  # it { should belong_to(:status) }
  it { should belong_to(:manager) }
  it { should have_many(:tender_categories).dependent(:destroy) }
  it { should have_many(:categories).through(:tender_categories) }
  it { should have_many(:user_tenders).dependent(:destroy) }
  it { should have_many(:users).through(:user_tenders) }
  it { should have_many(:items).dependent(:destroy) }
  it { should have_many(:user_items).through(:user_tenders).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:manager_id) }
  it { should validate_presence_of(:categories) }
  it { should validate_presence_of(:data_end) }
  it { should validate_presence_of(:data_start) }
  it { should have_attached_file(:fls) }
  it { should validate_attachment_content_type(:fls).allowing('image/png', 'image/jpeg', 'image/tiff',
                                                              'application/pdf', 'application/msword',
                                                              'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                                              'application/vnd.ms-excel',
                                                              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  it { should validate_attachment_size(:fls).less_than(2.megabytes) }
  it { expect(subject.status).to eq 'Открыт' }

  context 'when data_end < Time.zone.now' do
    before { subject.update(data_end: Time.zone.now - 1.hour) }

    it { expect(subject.overdue?).to be true }
  end



  describe 'Scopes' do
    let!(:tender_opened) { create :tender }
    let!(:tender_suspended) { create :tender, status_id: 2 }
    let!(:tender_finished) { create :tender, status_id: 3 }
    let!(:tender_archived) { create :tender, status_id: 4 }
    let!(:tender_two_stage) { create :tender, etap: 2 }

    context 'opened' do
      it { expect(Tender.opened).to match_array([tender_opened, tender_two_stage]) }
    end
    context 'suspended' do
      it { expect(Tender.suspended).to match_array(tender_suspended) }
    end
    context 'finished' do
      it { expect(Tender.finished).to match_array(tender_finished) }
    end
    context 'archived' do
      it { expect(Tender.archived).to match_array(tender_archived) }
    end
    context 'first_stage' do
      it { expect(Tender.first_stage).to_not match_array(tender_two_stage) }
    end
  end
end
