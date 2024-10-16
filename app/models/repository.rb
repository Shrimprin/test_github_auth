class Repository < ApplicationRecord
  belongs_to :user
  has_many :file_items
end
