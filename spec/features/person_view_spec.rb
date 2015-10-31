require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: 'FName', last_name: 'LName' ) }

  before(:each) do
    person.phone_numbers.create(number: '123445')
    person.phone_numbers.create(number: '678990')
    visit person_path(person)
  end

  it "shows the phone numbers on the person's page" do
    person.phone_numbers.each do |phone_number|
      expect(page).to have_content(phone_number.number)
    end
  end

  it "has a link to add a new phone number" do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end

  it "adds a new phone number" do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '1223')
    page.click_button('Create Phone number')

    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('1223')
  end

end
