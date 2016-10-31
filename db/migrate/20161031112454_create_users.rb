class CreateUsers < ActiveRecord::Migration
  def change
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    create_table :users do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
