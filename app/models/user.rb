class User < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  belongs_to :entity
  has_many :documents
  has_many :pages, through: :documents

  devise :database_authenticatable, :registerable, :confirmable

  #default_scope  ->{ includes(:api_key).references(:api_key) }
  before_validation do
    self.entity ||= Entity.find_by_name 'user'
  end

  #has_secure_password
  after_create :create_api_key

  #validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_with FieldValidator

  def validations
    Validation.joins(:entity).where(devise: {id: id})
  end

  private
  def create_api_key
    ApiKey.create :user => self
  end
end
