class Customer < ActiveRecord::Base
  has_many :orders

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  def Customer.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Customer.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Customer.hash(Customer.new_remember_token)
    end

end
