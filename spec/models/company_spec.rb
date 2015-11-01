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

  xit 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  xit 'has an array of emails' do
    expect(company.email_addresses).to eq([])
  end
end
