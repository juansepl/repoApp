class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.integer :id_repo
      t.string :login
      t.string :avatar
      t.string :url

      t.timestamps
    end
  end
end
