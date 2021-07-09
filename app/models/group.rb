class Group < ApplicationRecord
  belongs_to :user
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  attachment :image

  def group_by?(user)
    user_groups.where(user_id: user.id).exists?
  end
end
