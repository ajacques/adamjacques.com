class Location < ActiveRecord::Base
	def to_s
		"#{city}, #{admin_level1}"
	end

	def to_json
		"test"
	end
end
