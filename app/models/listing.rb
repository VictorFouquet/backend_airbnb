class Listing < ApplicationRecord
	belongs_to :city
	belongs_to :administrator, class_name: "User"
	has_many :reservations
end
