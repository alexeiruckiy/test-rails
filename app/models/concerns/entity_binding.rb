module EntityBinding
  extend ActiveSupport::Concern

  included do
    belongs_to :entity
    after_initialize :bind_to_entity

    validates_with FieldValidator
  end

  private
  def bind_to_entity
    self.entity ||= Entity.find_by_name(entity_name)
  end

  def entity_name
    self.class.name.demodulize.downcase
  end

end