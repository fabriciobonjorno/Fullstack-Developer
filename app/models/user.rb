# frozen_string_literal: true

class User < ActiveRecord::Base
  has_one_attached :avatar_image
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  enum status: %i[admin no_admin]


  def admin?
    role == 'admin'
  end
end
