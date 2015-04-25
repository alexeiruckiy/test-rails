class User < ActiveRecord::Base
  include EntityBinding

  has_many :documents
  has_many :pages, through: :documents
  has_and_belongs_to_many :roles

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable, :timeout_in => 30.minutes

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def is?(search_name)
    if new_record?
      role_names = [ Role::DEFAULT_ROLE ]
    else
      role_names = roles.collect(&:name)
    end
    role_names.include?(search_name)
  end

end
