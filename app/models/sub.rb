class Sub < ApplicationRecord
  validates :title, :description, presence: true
  validates :mod_id, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :mod_id,
    class_name: :User
end
