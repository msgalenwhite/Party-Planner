require 'spec_helper'

feature "user views list of parties" do

  scenario "should be re-directed from root path to parties" do
    cool_party = Party.create!(
      name: "Cool People Party",
      description: "We swear you'll like it",
      location: "The Arcade"
    )

    visit '/'

    expect(page).to have_content("Cool People Party")
  end

  scenario "view list of parties" do

    cool_party = Party.create!(
      name: "Cool People Party",
      description: "We swear you'll like it",
      location: "The Arcade"
    )

    other_party = Party.create!(
      name: "Not So Cool Party",
      description: "You probably won't hate it",
      location: "The Pool"
    )

    visit '/parties'

    expect(page).to have_content("Cool People Party")
    expect(page).to have_content("Not So Cool Party")

  end

  context "links lead to the correct locations" do
    scenario "new party link leads to the form page" do
      visit '/parties'
      click_link "Create your own!"

      expect(page).to have_content("Create a new party!")
    end

    scenario "friends link leads to friend index page" do
      visit '/parties'
      click_link("View Your Friends")

      expect(page).to have_content("Friends")
      expect(page).to have_content("Make a new friend!")
    end

    scenario "clicking on a party leads to that party's show page" do
      cool_party = Party.create!(
        name: "Cool People Party",
        description: "We swear you'll like it",
        location: "The Arcade"
      )

      other_party = Party.create!(
        name: "Not So Cool Party",
        description: "You probably won't hate it",
        location: "The Pool"
      )

      visit '/parties'
      click_link("Cool People Party")

      expect(page).to have_content("Cool People Party")
      expect(page).not_to have_content("Not So Cool Party")
    end
  end
end
