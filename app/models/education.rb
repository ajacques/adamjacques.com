class Education < ActiveRecord::Base
  # Associations
  belongs_to :organization
  belongs_to :location
  has_many :degrees

  scope :visible, -> { where(active: true) }

  alias __inspect__ inspect

  def method_missing(method, *arg)
    nil
  end
end
