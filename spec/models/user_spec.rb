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
