require 'rails_helper'

describe 'the company view', type: :feature do
  let(:company) { Company.create(name: 'Ghostbusters') }

  describe 'phone numbers' do
    before(:each) do
      company.phone_numbers.create(number: '123445')
      company.phone_numbers.create(number: '678990')
      visit company_path(company)
    end

    it "shows the phone numbers on the company's page" do
      company.phone_numbers.each do |phone_number|
        expect(page).to have_content(phone_number.number)
      end
    end

    it "has a link to add a new phone number" do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it "adds a new phone number" do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '1223')
      page.click_button('Create Phone number')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('1223')
    end

    it "has a link to edit phone numbers" do
      company.phone_numbers.each do |phone_number|
        expect(page).to have_link('Edit', edit_phone_number_path(phone_number))
      end
    end

    it "edits phone numbers" do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'Edit').click
      page.fill_in('Number', with: '098765')
      page.click_button('Update Phone number')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('098765')
      expect(page).to_not have_content(old_number)
    end

    it "has a link to delete phone numbers" do
      company.phone_numbers.each do |phone_number|
        expect(page).to have_link('Delete', phone_number_path(phone_number))
      end
    end

    it "deletes phone numbers" do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'Delete').click

      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
    end
  end

  describe "email addresses" do
    before(:each) do
      company.email_addresses.create(address: "email@email.com")
      company.email_addresses.create(address: "email2@email2.com")
      visit company_path(company)
    end

    it "shows the email addresses on the company's page" do
      expect(page).to have_selector('li', text: "email@email.com")
    end

    it "adds a new email address" do
      page.click_link('new_email_address')
      page.fill_in('Address', with: "new_email@email.com")
      page.click_button('Create Email address')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('new_email@email.com')
    end

    it "has links to edit each email" do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('Edit', edit_email_address_path(email_address))
      end
    end

    it "can edit an email" do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'Edit').click
      expect(current_path).to eq(edit_email_address_path(email))

      fill_in('Address', with: "new_email@gmail.com")
      click_button('Update Email address')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("new_email@gmail.com")
      expect(page).to_not have_content(old_email)
    end

    it "has links to delete an email" do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('Delete', email_addresses_path(email_address))
      end
    end

    it "can delete an email" do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'Delete').click

      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_email)
    end
  end
end
