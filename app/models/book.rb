class Book < ApplicationRecord
	belongs_to :user

	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	has_many :book_comments, dependent: :destroy

	has_many :view_counts, dependent: :destroy


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search_for(content, method)
		if method == "perfect"
			Book.where(title: content)
		elsif method == "forward"
			Book.where("title like ?", "#{content}%")
		elsif method == "backward"
			Book.where("title like ?", "%#{content}")
		else
			Book.where("title like ?", "%#{content}%")
		end
	end

	scope :today_books, -> { where(created_at: Time.zone.now.all_day) }
  scope :yesterday_books, -> { where(created_at: 1.day.ago.all_day) }
  scope :books_2day, -> { where(created_at: 2.day.ago.all_day) }
  scope :books_3day, -> { where(created_at: 3.day.ago.all_day) }
  scope :books_4day, -> { where(created_at: 4.day.ago.all_day) }
  scope :books_5day, -> { where(created_at: 5.day.ago.all_day) }
  scope :books_6day, -> { where(created_at: 6.day.ago.all_day) }
  scope :books_7day, -> { where(created_at: 7.day.ago.all_day) }
  scope :week_books, -> { where(created_at: 6.day.ago.at_beginning_of_day..Time.zone.now.at_end_of_day) }
  scope :last_week_books, -> { where(created_at: 2.week.ago.at_beginning_of_day..1.week.ago.at_end_of_day) }
end
