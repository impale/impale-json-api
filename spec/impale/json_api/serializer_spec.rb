require 'spec_helper'
require 'ostruct'

serializer_class = Class.new(Impale::JsonApi::Serializer) do
  attributes :name, :age,
             password: :digest_password
end

describe Impale::JsonApi::Serializer do
  let(:person) { OpenStruct.new(name: 'Pam', age: 24, digest_password: 'DWAaa')}
  subject(:serializer) { serializer_class.new(person) }

  describe 'initialize' do
    it 'has input' do
      expect(serializer.input).to eq person
    end
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(serializer.attributes).to eq [:name, :age, password: :digest_password]
    end
    describe 'serialize' do
      it 'returns a hash' do
        hash = serializer.serialize[:data][0][:attributes]
        expect(hash[:name]).to eq person.name
        expect(hash[:age]).to eq person.age
        expect(hash[:password]).to eq person.digest_password
      end
    end
  end
end
