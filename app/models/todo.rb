class Todo < ApplicationRecord
    mount_uploader :attachment, ImageUploader

    validates :title, presence: true, length: { maximum: 50 }
    validates :description, presence: true

    def remove_attachment
        self.remove_attachment!
        self.attachment = nil
        save
    end
end
