ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/reporters'
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Verifica que los campos de record coincidan con los de attributes después
  # de ejecutar el bloque
  def assert_record_differences(record, attributes, message = nil, &block)

    attributes.each do |key, value|
      if record.respond_to? key
        now = record.send(key)
        error = "#{key} value is '#{now}' which is the same as the expected new value"
        error = "#{message}\n#{error}" if message
        assert_not_equal value, now, error
      end
    end

    yield

    record.reload

    attributes.each do |key, value|
      if record.respond_to? key
        now = record.send(key)
        error = "#{key} didn't change its value to '#{value}', current value is '#{now}'"
        error = "#{message}\n#{error}" if message
        assert_equal value, now, error
      end
    end
  end

end
module LoggedUserTestable
  def setup
    @user = users(:ross)
    login_user(@user)
    super
  end
end
