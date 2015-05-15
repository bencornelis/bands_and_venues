require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("the venue path", type: :feature) do
  describe("adding and displaying a venue") do
    it('processes user entry to add and display a venue on the home page') do
      visit('/')
      fill_in('venue_name', with: "Crystal Ballroom")
      fill_in('location', with: "Portland")
      click_button('add_venue')
      expect(page).to have_content("Crystal Ballroom")
    end
  end
  describe("viewing and editing a venue") do
    it("lets user add bands to the list of bands that have played at the venue") do
      test_venue = Venue.create(name: "Crystal Ballroom", location: "Portland")
      band1 = Band.create(name: "Fleet Foxes", origin: "Seattle", year_founded: 2006)
      band2 = Band.create(name: "The Beatles")
      visit("/venues/#{test_venue.id}")
      check(band1.id)
      check(band2.id)
      click_button("Add bands")
      expect(page).to have_content("The Beatles")
    end
  end
end
