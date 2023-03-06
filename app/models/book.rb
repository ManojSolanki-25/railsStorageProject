class Book < ApplicationRecord
    has_one_attached :book_image
    validate :acceptable_image
    validates :name, presence: true

    def acceptable_image 
        return unless book_image.attached?

        unless book_image.blob.byte_size <= 1.megabyte
            errors.add(:book_image,"Is Too Big Image")
        end

        acceptable_types = ["image/jpeg","image/png"]

        unless acceptable_types.include?(book_image.content_type)
            errors.add(:book_image, "must be a JPEG or PNG")
        end
    end
end
