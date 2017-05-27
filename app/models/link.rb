class Link < ActiveRecord::Base
  scope :visible, (-> { where(active: true) })
end
