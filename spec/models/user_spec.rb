# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  crypted_password      :string           not null
#  password_salt         :string           not null
#  email                 :string           not null
#  persistence_token     :string           not null
#  single_access_token   :string           not null
#  perishable_token      :string           not null
#  created_at            :datetime
#  updated_at            :datetime
#  company               :string
#  function              :string
#  phone                 :string
#  adds                  :string
#  www                   :string
#  category_id_del       :integer
#  file_nds_file_name    :string
#  file_nds_content_type :string
#  file_nds_file_size    :integer
#  file_nds_updated_at   :datetime
#  file_reg_file_name    :string
#  file_reg_content_type :string
#  file_reg_file_size    :integer
#  file_reg_updated_at   :datetime
#  active                :boolean          default(FALSE), not null
#  login_count           :integer          default(0), not null
#  failed_login_count    :integer          default(0), not null
#  last_request_at       :datetime
#  current_login_at      :datetime
#  last_login_at         :datetime
#  current_login_ip      :string
#  last_login_ip         :string
#

require 'rails_helper'

describe User do

  it { should have_many(:user_categories) }
  it { should have_many(:categories).through(:user_categories ) }
  it { should have_many(:user_tenders).dependent(:destroy ) }
  it { should have_many(:user_items).through(:user_tenders ) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:function) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:adds) }
  it { should validate_presence_of(:categories) }
  it { should validate_presence_of(:file_nds) }
  it { should validate_presence_of(:file_reg) }

  it { should have_attached_file(:file_nds) }
  it { should validate_attachment_presence(:file_nds) }
  it { should validate_attachment_content_type(:file_nds).allowing('image/png', 'image/jpeg', 'image/tiff', 'application/pdf') }
  it { should validate_attachment_size(:file_nds).less_than(2.megabytes) }

  it { should have_attached_file(:file_reg) }
  it { should validate_attachment_presence(:file_reg) }
  it { should validate_attachment_content_type(:file_reg).allowing('image/png', 'image/jpeg', 'image/tiff', 'application/pdf') }
  it { should validate_attachment_size(:file_reg).less_than(2.megabytes) }

  describe '#prepend_www' do
    context 'when site is without protocol' do
      it 'prepends it with "http://"' do
        subject = described_class.new(www: 'ya.ru')
        subject.valid?
        expect(subject.www).to eq 'http://ya.ru'
      end
    end

    context 'when site is empty string' do
      it 'does not change' do
        subject = described_class.new(www: '')
        subject.valid?
        expect(subject.www).to eq ''
      end
    end

    context 'when site is with "https" protocol' do
      it 'does not change' do
        subject = described_class.new(www: 'https://ya.ru')
        subject.valid?
        expect(subject.www).to eq 'https://ya.ru'
      end
    end

    context 'when site is with "http" schema' do
      it 'does not change' do
        subject = described_class.new(www: 'http://ya.ru')
        subject.valid?
        expect(subject.www).to eq 'http://ya.ru'
      end
    end
  end
end
