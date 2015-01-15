class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas

  # enum roles = %w(default admin)
end
