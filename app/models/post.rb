class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 1, maximum: 250 }
  validates :body, presence: true

  def timestamp
    created_at.to_i
  end

  def err_msg
    errors.full_messages.join(', ')
  end
end
