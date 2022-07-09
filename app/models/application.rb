class Application < ApplicationRecord
    validates_uniqueness_of :token
    attribute :chats_count, :integer, default: 0
end
