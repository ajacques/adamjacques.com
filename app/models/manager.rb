class Manager < ApplicationRecord
    belongs_to :organization
    belongs_to :people
  end
  