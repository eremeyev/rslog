# frozen_string_literal: true

require 'factory_bot'

require 'simplecov'
SimpleCov.start

require_relative 'support/file_fixtures'
require_relative '../lib/rslog'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.supports_block_expectations = true
  config.include FileFixtures

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

def conf
  { title:  'Title',
    suffix: 'visits',
    calc:   proc { |visits| visits.size } }
end

def source_data
  ["/help_page/1 126.318.035.038\n",
   "/contact 184.123.665.067\n",
   "/home 184.123.665.067\n",
   "/about/2 444.701.448.104\n",
   "/about 722.247.931.582\n"]
end

def sorted_data
  [['/about', 1], ['/about/2', 1], ['/home', 1], ['/contact', 1], ['/help_page/1', 1]]
  #  [['/about', 1, 0.2], ['/about/2', 1, 0.2], ['/home', 1, 0.2], ['/contact', 1, 0.2], ['/help_page/1', 1, 0.2]]
end

def valid_data
  [
    '/help_page/1 126.126.126.126',
    '/contact 184.123.100.067',
    '/home 184.123.100.067',
    '/about/2 100.100.100.104',
    '/about 100.247.100.100'
  ]
end

def invalid_ips
  {
    '/help_page/1' => [['/help_page/1', '126.318.035.038']],
    '/contact' => [['/contact', '184.123.665.067']],
    '/home' => [['/home', '184.123.665.067']],
    '/about/2' => [['/about/2', '444.701.448.104']],
    '/about' => [['/about', '722.247.931.582']]

  }
end

def sorted_hash
  [
    ['/index', '2'],
    ['/about', '1'],
    ['/home', '1']
  ]
end

def extracted_data
  [['/help_page/1', '126.318.035.038'],
   ['/contact', '184.123.665.067'],
   ['/home', '184.123.665.067'],
   ['/about/2', '444.701.448.104'],
   ['/about', '722.247.931.582']]
end

def grouped_data
  [['/help_page/1', [['/help_page/1', '126.318.035.038']]],
   ['/contact', [['/contact', '184.123.665.067']]],
   ['/home', [['/home', '184.123.665.067']]],
   ['/about/2', [['/about/2', '444.701.448.104']]],
   ['/about', [['/about', '722.247.931.582']]]]
end

def calculated_data
  [['/help_page/1', 1], ['/contact', 1], ['/home', 1], ['/about/2', 1], ['/about', 1]]
end
