require 'securerandom'

class User < ActiveRecord::Base
  before_create :create_uuid

  def create_uuid
      self.uuid = SecureRandom.uuid
  end
end
