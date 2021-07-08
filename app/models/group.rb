class Group < ApplicationRecord
  belongs_to :user
  attachment :image
end
