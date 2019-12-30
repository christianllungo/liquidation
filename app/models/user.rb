require 'bcrypt'
class User < ApplicationRecord
    include BCrypt
    validates :username, :password_digest, :session_token, :phone_number, :email, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token
    attr_reader :password

    has_many :products, dependent: :destroy

    # generates a random session token
    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    # calls g random and resets a random token to @session_token
    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    # overrides the password setter method so that it BCrypts the input and
    # gets stored in the @password_digest
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    # verifies whether or not password input matches with @password_digest 
    # BCrypted equivalent
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    # finds the user given inputs username and password
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    # validation method to call g random if @session_token is not set
    private
    def ensure_session_token
        # we must be sure to use the ||= operator instead of = or ||, otherwise
        # we will end up with a new session token every time we create
        # a new instance of the User class. This includes finding it in the DB!
        self.session_token ||= self.class.generate_session_token
    end
end
