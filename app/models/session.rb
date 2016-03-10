require 'securerandom'

class Session < ActiveRecord::Base
  before_create :set_token

  def get_token
    @token_id
  end

  private
  def set_token
    self.token_id = generate_token    
  end

  def generate_token
    SecureRandom.urlsafe_base64(3)
  end
end
