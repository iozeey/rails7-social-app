class Group < ApplicationRecord
    belongs_to :user
    has_many :group_users
    has_many :groups, through: :group_users
end
