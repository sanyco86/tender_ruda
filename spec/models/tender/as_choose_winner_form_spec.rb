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

describe Tender::AsChooseWinnerForm do
  it { should accept_nested_attributes_for(:items) }
end
