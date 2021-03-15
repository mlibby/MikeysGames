require "date"
require "sequel"
require "sequel/extensions/seed"

module MikeysGames
  class Repo
    def initialize(db_connection)
      @db = Sequel::Model.db = Sequel.connect db_connection

      Sequel.extension :migration
      Sequel::Migrator.run @db, "#{__dir__}/migrations"

      if ENV["APP_ENV"] != "TEST"
        # :nocov:
        Sequel.extension :seed
        Sequel::Seeder.apply @db, "#{__dir__}/seeds"
        # :nocov:
      end

      if ["DEMO"].include? ENV["APP_ENV"] 
        require_relative "../../spec/seeds/seed_db"
        seed_db
      end
    end

    def Repo.timestamp
      DateTime.now.new_offset(0).to_s
    end
  end
end
