class Person < ActiveRecord::Base
  has_many :phone_numbers, as: :contact
  has_many :email_addresses, as: :contact
  validates :first_name, presence: true
  validates :last_name, presence: true
end
