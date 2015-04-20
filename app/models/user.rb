class User < ActiveRecord::Base
  belongs_to :entity
  has_many :documents
  has_many :pages, through: :documents
  has_and_belongs_to_many :roles

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable, :timeout_in => 30.minutes

  before_create :bind_to_entity

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_with FieldValidator


  def validations
    Validation.joins(:entity).where(users: {id: id})
  end


  def is?(search_name)
    if new_record?
      role_names = [ Role::DEFAULT_ROLE ]
    else
      role_names = roles.collect(&:name)
    end
    role_names.include?(search_name)
  end

  private
  def bind_to_entity
    self.entity = Entity.find_by_name('user')
  end

end
