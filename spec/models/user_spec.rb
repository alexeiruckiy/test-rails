require 'rails_helper'

describe User, :type => :model do

  it 'has default role' do
    user = User.new
    expect(user.is?(Role::DEFAULT_ROLE)).to eq(true)
  end

  it 'should be assigned to User entity' do
    expect(User.new.entity).to eq(Entity.find_by_name('user'))
  end

end