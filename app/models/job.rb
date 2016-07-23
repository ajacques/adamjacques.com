class Job < ActiveRecord::Base
	# Associations
	belongs_to :location
	belongs_to :organization
	has_many :responsibilities, class_name: 'Description'

	scope :visible, -> { includes(:responsibilities, :location, :organization).order('start_date DESC').active }
	scope :active, -> { where(active: true) }
end
