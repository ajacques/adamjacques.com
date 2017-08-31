class Link < ApplicationRecord
  scope :visible, (-> { where(active: true) })
end
