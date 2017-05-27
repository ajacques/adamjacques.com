class Education < ActiveRecord::Base
  # Associations
  belongs_to :organization
  belongs_to :location
  has_many :degrees

  scope :visible, (-> { where(active: true) })
end
