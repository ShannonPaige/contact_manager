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
end
