class Photo < ApplicationRecord
  has_attached_file :url, :storage => :cloudinary, :path => ':id/:filename'
  validates_attachment_content_type :url, content_type: /\Aimage\/.*\Z/

  belongs_to :fighter
end
