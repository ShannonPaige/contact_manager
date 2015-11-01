require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: 'FName', last_name: 'LName' ) }

  describe 'phone numbers' do
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

    it "has a link to edit phone numbers" do
      person.phone_numbers.each do |phone_number|
        expect(page).to have_link('Edit', edit_phone_number_path(phone_number))
      end
    end

    it "edits phone numbers" do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'Edit').click
      page.fill_in('Number', with: '098765')
      page.click_button('Update Phone number')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('098765')
      expect(page).to_not have_content(old_number)
    end

    it "has a link to delete phone numbers" do
      person.phone_numbers.each do |phone_number|
        expect(page).to have_link('Delete', phone_number_path(phone_number))
      end
    end

    it "deletes phone numbers" do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'Delete').click

      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_number)
    end
  end

  describe "email addresses" do
    before(:each) do
      person.email_addresses.create(address: "email@email.com")
      person.email_addresses.create(address: "email2@email2.com")
      visit person_path(person)
    end

    it "shows the email addresses on the person's page" do
      expect(page).to have_selector('li', text: "email@email.com")
    end

    it "adds a new email address" do
      page.click_link('new_email_address')
      page.fill_in('Address', with: "new_email@email.com")
      page.click_button('Create Email address')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('new_email@email.com')
    end

  end
end
