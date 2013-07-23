class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string  :name
	    t.string  :document_type
	    t.string  :document_number
  		t.string  :address    	

      t.timestamps
    end
  end
end
