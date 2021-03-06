class Job < ApplicationRecord
  # Associations
  belongs_to :location
  belongs_to :organization
  has_many :responsibilities, class_name: 'Description', inverse_of: :job

  scope :visible, (-> { includes(:responsibilities, :location, :organization).order('start_date DESC').active })
  scope :active, (-> { where(active: true) })
end
