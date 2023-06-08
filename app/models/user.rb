class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :secure_validatable # ,  :validatable
  # devise :password_expirable, :secure_validatable, :password_archivable, :session_limitable, :expirable

  validates_format_of :email, with: /\A\w+\z/

  # validates_presence_of   :email, if: :email_required?
  # validates_uniqueness_of :email, allow_blank: true, case_sensitive: true, if: :devise_will_save_change_to_email?
  # validates_format_of     :email, with: email_regexp, allow_blank: true, if: :devise_will_save_change_to_email?

  # validates_presence_of     :password, if: :password_required?
  # validates_confirmation_of :password, if: :password_required?
  # validates_length_of       :password, within: password_length, allow_blank: true

  def admin?
    is_admin == '1'
  end
end
