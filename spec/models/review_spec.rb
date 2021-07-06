require 'rails_helper'

RSpec.describe Review do
  describe 'Relationships' do
    it {should belong_to :item}
  end

describe "validations" do
  it { should validate_presence_of :title}
  it { should validate_presence_of :content }
end
end
