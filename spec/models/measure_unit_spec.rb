# == Schema Information
#
# Table name: measure_units
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe MeasureUnit do

  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
end
