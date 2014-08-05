class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.integer :user_id
      t.string :chatname
      t.string :message

      t.timestamps
    end
  end
end
