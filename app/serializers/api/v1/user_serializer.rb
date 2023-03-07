class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :role, :url_image, :avatar
  def avatar
    object.avatar_image.attached? ? rails_blob_url(object.avatar_image) : false
  end
end
