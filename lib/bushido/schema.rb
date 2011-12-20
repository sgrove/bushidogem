module Bushido
  # Holds devise schema information. To use it, just include its methods
  # and overwrite the apply_schema method.
  module Schema

    # Creates reset_password_token and reset_password_sent_at.
    #
    # == Options
    # * :reset_within - When true, adds a column that reset passwords within some date
    def recoverable(options={})
      use_within = options.fetch(:reset_within, Devise.reset_password_within.present?)
      apply_devise_schema :reset_password_token, String
      apply_devise_schema :reset_password_sent_at, DateTime if use_within
    end

    # Creates remember_token and remember_created_at.
    #
    # == Options
    # * :use_salt - When true, does not create a remember_token and use password_salt instead.
    def rememberable(options={})
      use_salt = options.fetch(:use_salt, Devise.use_salt_as_remember_token)
      apply_devise_schema :remember_token,      String unless use_salt
      apply_devise_schema :remember_created_at, DateTime
    end

    # Creates sign_in_count, current_sign_in_at, last_sign_in_at,
    # current_sign_in_ip, last_sign_in_ip.
    def trackable
      apply_devise_schema :sign_in_count,      Integer, :default => 0
      apply_devise_schema :current_sign_in_at, DateTime
      apply_devise_schema :last_sign_in_at,    DateTime
      apply_devise_schema :current_sign_in_ip, String
      apply_devise_schema :last_sign_in_ip,    String
    end


    # Overwrite with specific modification to create your own schema.
    def apply_devise_schema(name, type, options={})
      raise NotImplementedError
    end
  end
end