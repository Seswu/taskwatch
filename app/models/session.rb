require 'securerandom'

class Session < ActiveRecord::Base
  before_create :set_token

  def get_token
    #self.token_id = generate_token
    self.token_id
  end

  def set_pub_token
    set_token
  end

  private
  def initialize
    super
    @token_id = generate_token
    #self.token_id = generate_token
  end
  
  def set_token
    #return if token_id.present?
    self.token_id = generate_token
  end

  def generate_token
    SecureRandom.urlsafe_base64(3)
  end
end
