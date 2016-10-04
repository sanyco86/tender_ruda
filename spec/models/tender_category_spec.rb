# == Schema Information
#
# Table name: tender_categories
#
#  id          :integer          not null, primary key
#  tender_id   :integer
#  category_id :integer
#

require 'rails_helper'

describe TenderCategory do
  it { should belong_to(:tender) }
  it { should belong_to(:category) }
end
