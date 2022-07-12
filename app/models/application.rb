class Application < ApplicationRecord
    validates :name, presence: true
    validates_uniqueness_of :token
    attribute :chats_count, :integer, default: 0
    has_many :chats, dependent: :delete_all
end
