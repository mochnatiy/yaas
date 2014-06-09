class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :timestamp, :err_msg
end
