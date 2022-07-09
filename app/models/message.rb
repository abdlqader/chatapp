class Message < ApplicationRecord
  belongs_to :chat
  validates_uniqueness_of :number, scope: :chat_id
end
