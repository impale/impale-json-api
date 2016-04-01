require 'spec_helper'
require 'ostruct'

serializer_post_class = Class.new(Impale::JsonApi::Serializer) do
  type :posts
  id :title

  attributes :title, :content
end

serializer_company_class = Class.new(Impale::JsonApi::Serializer) do
  type :companies
  id :name
end

serializer_person_class = Class.new(Impale::JsonApi::Serializer) do
  type :persons
  id :name

  attributes :name, :age,
             password: :digest_password

  has_many :posts, serializer: serializer_post_class
  belongs_to :company, serializer: serializer_company_class
end

describe Impale::JsonApi::Serializer do
  let(:person) do
    OpenStruct.new(name: 'Pam', age: 24, digest_password: 'DWAaa', posts: posts, company: company)
  end

  let(:company) do
    OpenStruct.new(name: 'company')
  end

  let(:posts) do
    arr = []
    3.times { |count| arr << OpenStruct.new(title: "title #{count}", content: 'kontent')  }
    arr
  end

  subject(:serializer) { serializer_person_class.new([person, person]) }
end