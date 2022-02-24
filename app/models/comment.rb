class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  after_create_commit  { broadcast_prepend_to 'comments' }
  after_update_commit  { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to  'comments' }

  validates :comment, presence: true
end
