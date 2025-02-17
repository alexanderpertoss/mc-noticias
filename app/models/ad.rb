class Ad < ApplicationRecord
	has_one_attached :main_image

	after_initialize :attach_default_image, if: -> { new_record? && !main_image.attached? }

	private

	def attach_default_image
	    default_image_path = Rails.root.join("app/assets/images/ads-728x90.png")
	    main_image.attach(io: File.open(default_image_path), filename: "ads-728x90.png", content_type: "image/png")
	end
end
