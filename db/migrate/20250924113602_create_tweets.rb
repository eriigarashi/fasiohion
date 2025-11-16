class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.float :kion
      t.text :review

      t.timestamps
    end
  end
end
