require 'spec_helper'

describe Impale::JsonApi::HashObjectTraversor do
  let(:person) { OpenStruct.new(name: 'Pam', age: 24, digest_password: 'DWAaa')}
  subject(:traversor) { Impale::JsonApi::HashObjectTraversor.new(person) }

  describe 'traverse_non_nested' do
    context 'not renamed' do
      it 'returns the name and age' do
        list = :name, :age
        result = traversor.traverse_non_nested(list)
        expect(result[:name]).to eq person.name
        expect(result[:age]).to eq person.age
      end
    end

    context 'renamed' do
      it 'returns the password and age' do
        list = [password: :digest_password, new_age: :age]
        result = traversor.traverse_non_nested(list)
        expect(result[:password]).to eq person.digest_password
        expect(result[:new_age]).to eq person.age
      end
    end
  end
end
