class Order < ActiveRecord::Base
	belongs_to :room
	belongs_to :user

	validates :check_in, presence: true
	validates :check_out, presence: true
end
