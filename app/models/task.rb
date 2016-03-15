class Task < ActiveRecord::Base
  belongs_to :session
  validates :name, presence: true, length: { minimum: 3 }
  validates :settings, presence: true, length: { minimum: 1 }
  validates :session_id, presence: true
end
