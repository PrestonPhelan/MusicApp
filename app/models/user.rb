class User < ActiveRecord::Base

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)
    return nil if @user.nil? || !@user.is_password?(password)

    @user
  end

  attr_reader :password

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    digest = BCrypt::Password.create(password)
    self.password_digest = digest
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
