require 'rails_helper'

describe Document, :type => :model do

  def blank_document
    document = FactoryGirl.build(:document)
    DocumentBuilder.new(document).create_blank!
  end

  it 'should be assigned to Document entity' do
    expect(Document.new.entity).to eq(Entity.find_by_name('document'))
  end

  it 'should has possibility to create blank document' do
    expect{blank_document}.not_to raise_error
  end

  it 'should correctly assign page number of a new blank document' do
    pages = blank_document.pages
    expect(pages.count).to eq(1)
    expect(pages[0].number).to eq(1)
  end
end