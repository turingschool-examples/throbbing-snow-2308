require "rails_helper"

RSpec.describe "experiment index page",type: :feature do
    before(:each) do
        @anna = Passenger.create(name: "Anna")
        @beth = Passenger.create(name: "Beth")
        @carl = Passenger.create(name: "Carl")
        @debb = Passenger.create(name: "Debb")
        @ella = Passenger.create(name: "Ella")

        @united = Airline.create(name: "United")
        @un_flight_1 = @united.flights.create(number: "1")
        @un_flight_2 = @united.flights.create(number: "2")
        PassengerFlight.create(passenger: @anna, flight: @un_flight_1)
        PassengerFlight.create(passenger: @beth, flight: @un_flight_1)
        PassengerFlight.create(passenger: @carl, flight: @un_flight_2)

        @southwest = Airline.create(name: "SouthWest")
        @sw_flight_1 = @southwest.flights.create(number: "3")
        @sw_flight_2 = @southwest.flights.create(number: "4")
        PassengerFlight.create(passenger: @debb, flight: @sw_flight_1)
        PassengerFlight.create(passenger: @ella, flight: @sw_flight_2)
    end

    it "User Story 1, Flights Index Page" do
        # When I visit the flights index page
        visit "/flights"
        # I see a list of all flight numbers
        expect(page).to have_content(@un_flight_1.number)
        expect(page).to have_content(@un_flight_2.number)
        expect(page).to have_content(@sw_flight_1.number)
        expect(page).to have_content(@sw_flight_2.number)
        # And next to each flight number I see the name of the Airline of that flight
        expect(page).to have_content(@united.name)
        # And under each flight number I see the names of all that flight's passengers
        expect(@united.name).to appear_before(@carl.name)

        save_and_open_page
    end
end