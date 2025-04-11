class Ad < ApplicationRecord
	has_one_attached :main_image

	after_initialize :attach_default_image, if: -> { new_record? && !main_image.attached? }

	def self.small_ad
		# Ad with id=1 is the small one
		Ad.find(1)
	end

	def self.lateral_ad
		# Ad with id=2 is the lateral one
		Ad.find(2)
	end

	def self.bottom_ad
		# Ad with id=3 is the lateral one
		Ad.find(3)
	end

	private
	def attach_default_image
	    default_image_path = Rails.root.join("app/assets/images/ads-728x90.png")
	    main_image.attach(io: File.open(default_image_path), filename: "ads-728x90.png", content_type: "image/png")
	end
end
