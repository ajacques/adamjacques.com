class KeyPoint < ActiveRecord::Base
	has_many :sub_points, :class_name => 'KeyPoint', :foreign_key => 'parent_id'
	belongs_to :parent, :class_name => 'KeyPoint', :inverse_of => :sub_points
end
