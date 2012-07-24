source 'https://rubygems.org'

gem 'rails'
gem 'inherited_resources'

group :development, :test do

  gem 'rspec'
  # Testing infrastructure
  gem 'guard'
  gem 'guard-rspec'

  if RUBY_PLATFORM =~ /darwin/
    # OS X integration
    gem "ruby_gntp"
    gem "rb-fsevent", "~> 0.4.3.1"
  end
end

# Specify your gem's dependencies in amy_admin.gemspec
gemspec

