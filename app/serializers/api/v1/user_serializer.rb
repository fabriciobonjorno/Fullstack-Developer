class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :role, :url_image, :avatar_image
end
