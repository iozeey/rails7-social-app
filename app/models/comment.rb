class Comment < ApplicationRecord
    belongs_to :post, optional: true
    belongs_to :user, optional: true
    belongs_to :parent,  class_name: "Comment", optional: true #-> requires "parent_id" column
    has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
end
