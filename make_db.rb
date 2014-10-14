require_relative 'models'
ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :name
  end

  create_table :posts do |t|
    t.string :name
    t.integer :user_id
  end
end
