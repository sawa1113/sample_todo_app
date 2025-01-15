class Todo < ApplicationRecord
    mount_uploader :attachment, ImageUploader

    validates :title, presence: true, length: { maximum: 50 }
    validates :description, presence: true
end
