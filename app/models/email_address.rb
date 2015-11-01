class EmailAddress < ActiveRecord::Base
  belongs_to :contact, polymorphic: :true
  validates :address, presence: :true
  validates :contact_id, presence: :true
end
