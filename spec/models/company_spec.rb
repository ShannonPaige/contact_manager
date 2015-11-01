require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company){ Company.new(name: "Awesome Company") }

  it "is valid" do
    expect(company).to be_valid
  end

  it "is invalid without a name" do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    phone_number = company.phone_numbers.build(number: '1-800-No-Ghosts')
    expect(phone_number.number).to eq('1-800-No-Ghosts')
  end

  it 'has an array of emails' do
    email = company.email_addresses.build(address: 'professionalemail@company.com')
    expect(email.address).to eq('professionalemail@company.com')
  end
end
