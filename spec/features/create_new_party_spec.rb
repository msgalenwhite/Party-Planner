require 'spec_helper'

feature 'user can create a new party' do
  scenario 'user can see party form' do
    visit '/parties/new'

    expect(page).to have_content('Create a new party!')
    expect(page).to have_selector('form')
  end

  xscenario 'user completely fills form and creates new party' do
    visit '/parties/new'

    fill_in('Name:', with: 'New Cool Party')
    fill_in('Location:', with: 'My Place')
    fill_in('Description:', with: 'It will be fun, I swear!')

    click_button('Submit')

    expect(page).to have_content('Parties')
    expect(page).to have_content('New Cool Party')
  end

end
