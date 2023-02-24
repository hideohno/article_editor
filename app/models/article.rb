class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy

  validates :title, :body, presence: true
  enum status: { draft: "draft", published: "published" }
end
