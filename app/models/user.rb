class User < ActiveRecord::Base

  has_secure_password
  
  def self.authenticate_with_credentials email, password
    email.strip!
    email.downcase!
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      user
    else 
      nil
    end

  end 

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 5} 
  validates :password_confirmation, presence: true 
end


# Define a new class method authenticate_with_credentials on the User model.
# It will take as arguments: the email address and password the user typed into the login form,
# And return: an instance of the user (if successfully authenticated), or nil (otherwise).
# Use it in your Sessions controller, as in the example below:

