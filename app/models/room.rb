class Room < ActiveRecord::Base
	belongs_to :user
	has_many :orders

	validates :price_in_pence, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :name, presence: true
	validates :address, presence: true
	validates :longitude, presence: true
	validates :latitude, presence: true

	geocoded_by :address
	before_validation :geocode
end
