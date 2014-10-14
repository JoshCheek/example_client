require_relative 'models'
user = User.create! name: 'Josh'
user.posts = [Post.new(name: 'yo ho ho'),
              Post.new(name: 'and a bottle of rum')]

user = User.create! name: 'Jeff'
user.posts = [Post.new(name: 'Hi-de-ho-de-hum'),
              Post.new(name: 'rum pum pum pum')]
