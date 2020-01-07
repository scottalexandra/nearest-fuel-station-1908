require 'rails_helper'

describe "user can search for nearest fuel station" do
  it "displays the fuel station information" do
    # When I visit "/"
    visit '/'
    # And I select "Turing" from the start location drop down (Note: Use the existing search form)
    select 'Turing', from: :location
    # And I click "Find Nearest Station"
    click_button "Find Nearest Station"
    # Then I should be on page "/search"
    expect(current_path).to eq(search_path)
    # Then I should see the closest electric fuel station to me.
    expect(page).to have_css('.station')
    # For that station I should see
    within('.station') do
    # - Name
    expect(page).to have_css('.name')
    expect(first('.name').text).to_not be_empty
    # - Address
      expect(page).to have_css('.address')
      expect(first('.address').text).to_not be_empty
      # - Fuel Type
      expect(page).to have_css('.fuel_type')
      expect(first('.fuel_type').text).to_not be_empty
      # - Access Times
      expect(page).to have_css('.access_times')
      expect(first('.access_times').text).to_not be_empty
      # I should also see:
      # - the distance of the nearest station (should be 0.1 miles)
      expect(page).to have_css('.distance')
      expect(first('.distance').text).to_not be_empty
      # - the travel time from Turing to that fuel station (should be 1min)
      expect(page).to have_css('.travel_time')
      expect(first('.travel_time').text).to_not be_empty
      # - The HTML direction instructions to get to that fuel station
      #   "Head <b>southeast</b> on <b>17th St</b> toward <b>Larimer St</b>"
      expect(page).to have_css('.directions')
      expect(first('.directions').text).to_not be_empty
    end
  end
end
