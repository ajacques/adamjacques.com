class Location < ApplicationRecord
  def to_s
    "#{city}, #{admin_level1}"
  end
end
