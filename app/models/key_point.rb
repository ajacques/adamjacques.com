class KeyPoint < ApplicationRecord
  has_many :sub_points, class_name: 'KeyPoint', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'KeyPoint', inverse_of: :sub_points

  scope :root, (-> { joins(:parent).where(active: true, parents_key_points: { value: 'root' }).order(:sort) })
end
