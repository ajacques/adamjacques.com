class Manager < ApplicationRecord
  belongs_to :organization
  belongs_to :person, class_name: 'People'
end
