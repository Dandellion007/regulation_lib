class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :secure_validatable 

  validates_format_of :email, with: /\A\w+\z/


  def admin?
    is_admin == '1' || is_admin == true || is_admin == 't'
  end
end
