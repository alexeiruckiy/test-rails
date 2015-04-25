require 'rails_helper'

describe Entity, :type => :model do

  it 'should exists all necessary entities ' do
    expect(Entity.pluck(:name)).to match_array(%w(user document))
  end
end