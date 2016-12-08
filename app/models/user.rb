class User < ActiveRecord::Base
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials
    @user = User.find_by(email: params[:email])
    return nil if @user.nil || !@user.is_password?(params[:password])

    @user
  end

  attr_reader :password

  def ensure_session_token
    @session_token ||= User.generate_session_token
  end

  def reset_session_token!
    @session_token = User.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
