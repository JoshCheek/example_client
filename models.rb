require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: File.expand_path('../db.sqlite', __FILE__)

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end
