# Impale::Json::Api

### Simple way to serialize objects

```ruby    
    class Person
      attr_accessor :id, :name, :age, :posts
    end
    
    class Post
      attr_accessor :id, :title, :content, :person
    end
    
    class PersonSerializer < Impale::JsonApi::Serializer
      id :id
      type :persons
      attributes :name, :age
      
      has_many :posts, serializer: PostsSerializer
    end
    
    class PostsSerializer < Impale::JsonApi::Serializer
      id :id
      type :posts
      attributes :content, title: :custom_title_field
      
      belongs_to :person, serializer: PersonSerializer
    end
    
    person = Person.new
    posts = [Post.new, Post.new]
    person.posts = posts
    
    hash = Impale::JsonApi::Serializer.new(person).serialize
    #for rails
    render json: hash
```


## Installation

```ruby
gem 'impale-json-api'
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

