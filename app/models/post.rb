class Post < ApplicationRecord
    has_many :comments
    validates_presence_of :title
    validates_presence_of :content
    
    before_save :set_last_activity

    def set_last_activity
        self.last_activity = Time.now
    end
end
