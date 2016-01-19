class Job < ActiveRecord::Base
	# Associations
	belongs_to :location
	belongs_to :organization
	has_many :responsibilities, class_name: 'Description'

	def self.active
		self.where(active: true)
	end
end
