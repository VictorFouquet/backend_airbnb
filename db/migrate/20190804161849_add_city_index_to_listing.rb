class AddCityIndexToListing < ActiveRecord::Migration[5.2]
  def change
  	add_reference :listings, :city, foreign_key: true
  end
end
