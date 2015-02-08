class User < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  belongs_to :entity
  has_many :documents
  has_many :pages, through: :documents
  has_and_belongs_to_many :roles

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable, :timeout_in => 30.minutes

  #default_scope  ->{ includes(:api_key).references(:api_key) }
  after_initialize :init_entity
  after_create :create_api_key

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_with FieldValidator


  def validations
    Validation.joins(:entity).where(users: {id: id})
  end

  DEFAULT_ROLE = 'guest'
  def is?(search_name)
    if new_record?
      search_name == DEFAULT_ROLE
    else
      search_role = roles.find { |role| role.name == search_name.to_s }
      !search_role.nil?
    end
  end

  private
  def create_api_key
    ApiKey.create(user: self)
  end

  def init_entity
    self.entity ||= Entity.find_by_name('user')
  end
end
