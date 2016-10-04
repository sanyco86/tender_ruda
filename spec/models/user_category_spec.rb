# == Schema Information
#
# Table name: user_categories
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#

require 'rails_helper'

describe UserCategory do

  it { should belong_to(:user) }
  it { should belong_to(:category) }
end
