Sequel.migration do
  change do
    create_table(:user) do
      primary_key :user_id
      String :username, text: true, null: false
    end
  end
end
