class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

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

	has_secure_password

end
