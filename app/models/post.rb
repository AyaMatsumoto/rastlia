class Post < ApplicationRecord
  validates :video_url, { presence: true }
  #validates :channel_url, { presence: true }
  validates :password, { presence: true, length: { maximum: 8, minimum: 4 } }
  #validates :content, { presence: true }
end
