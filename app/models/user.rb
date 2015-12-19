class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_create :generate_authentication_token!

	before_save {
		self.email = email.downcase
		self.name = name.downcase
	}

	validates :name, 	presence: true,
										length: { minimum: 3, maximum: 50 }

	validates :email, 	presence: true,
											length: { minimum: 5, maximum: 255 },
											format: { with: VALID_EMAIL_REGEX },
											uniqueness: { case_sensitive: false }

	validates :auth_token, uniqueness: true

	has_secure_password

	# private

	def generate_authentication_token!
    begin
      self.auth_token = SecureRandom.hex
    end while User.exists?(auth_token: auth_token)
  end

end
