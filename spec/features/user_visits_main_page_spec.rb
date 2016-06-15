require 'spec_helper'

feature 'User visits main page' do
  scenario 'with opened tenders' do
    category = create :category
    tender = create :tender, categories: [category]
    finished_tender = create :tender, :finished, categories: [category], name: 'Finished tender'

    visit '/'

    expect(page).to have_text(tender.name)
    expect(page).not_to have_text(finished_tender.name)
  end
end
