class Podcast < ApplicationRecord
	validates :title, presence: true, length: { minimum: 5 }
  	validates :link_to_podcast, presence: true, length: { minimum: 5 }
end
