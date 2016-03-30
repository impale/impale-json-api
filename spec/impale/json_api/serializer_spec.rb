require 'spec_helper'
require 'ostruct'

serializer_class = Class.new(Impale::JsonApi::Serializer) do

end

describe Impale::JsonApi::Serializer do
  let(:person) { OpenStruct.new(name: 'Pam', age: 24)}
  subject(:serializer) { serializer_class.new(person) }

  describe 'initialize' do
    it 'has obj' do
      expect(serializer.obj).to eq person
    end
  end

  describe 'attributes' do
    xit 'has attributes' do
      expect(serializer.attributes).not_to be_nil
    end
  end
end
