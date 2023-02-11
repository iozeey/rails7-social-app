class Group < ApplicationRecord
    belongs_to :user
    has_many :posts
    has_many :group_users
    has_many :groups, through: :group_users

    before_save :set_last_activity

    def set_last_activity
        self.last_activity = Time.now
    end
end
