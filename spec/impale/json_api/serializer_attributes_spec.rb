require 'spec_helper'
require 'ostruct'

serializer_class = Class.new(Impale::JsonApi::Serializer) do
  type :persons
  id :name

  attributes :name, :age,
             password: :digest_password
end

describe Impale::JsonApi::Serializer do
  let(:person) { OpenStruct.new(name: 'Pam', age: 24, digest_password: 'DWAaa')}
  subject(:serializer) { serializer_class.new([person, person]) }

  describe 'initialize' do
    it 'has input' do
      expect(serializer.input).to eq [person, person]
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

  describe 'type' do
    it 'has type' do
      expect(serializer.type).to eq :persons
    end
    describe 'serialize' do
      it 'returns a type' do
        type = serializer.serialize[:data][0][:type]
        expect(type).to eq :persons
      end
    end
  end

  describe 'id' do
    it 'has id' do
      expect(serializer.id).to eq :name
    end
    describe 'serialize' do
      it 'returns a id' do
        id = serializer.serialize[:data][0][:id]
        expect(id).to eq person.name
      end
    end
  end
end
