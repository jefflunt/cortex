class InitialSchema < ActiveRecord::Migration
  def change
    create_table :cortex do |t|
      t.string  :code
      t.string  :title

      t.timestamps
    end
        
    create_table :thought do |t|
      t.text    :text
      t.boolean :scratched
      
      t.timestamps
    end
  end
end
