source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "sequel"
gem "sequel-seed"
gem "sinatra"
gem "sinatra-flash"
gem "haml"
gem "thin"

group :dev, :test, :prod do
  gem "sqlite3"
end

group :test do
  gem "rake"
  gem "rspec"
  gem "rspec-mocks"
  gem "rspec-html-matchers"
  gem "rack-test"
  gem "simplecov"
end
