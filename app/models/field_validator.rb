class FieldValidator < ActiveModel::Validator
  def validate(record)
    record.entity.validations.each do |validation|
      value = record.read_attribute(validation.field)
      unless value =~ Regexp.new(validation.rule)
          record.errors[validation.field] << validation.message
      end
    end
  end
end