class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	before_save { email.downcase! }
	validates :name, presence: true
	validates :email, presence: true,uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	has_many :results
	has_many :questions, :through => :results

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
