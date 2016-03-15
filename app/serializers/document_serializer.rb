class DocumentSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :description, :created_at, :entity_id, :pages_count, :user_id
end
