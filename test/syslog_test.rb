$LOAD_PATH.unshift( File.dirname(__FILE__) )

require 'test_helper'

FIXTURE_SYSLOG_MESSAGE = "<12>Jan  3 16:18:58 rechenschieber.local nodejs[36180]: message"

class RpmTest < Test::Unit::TestCase
  context 'regex maching' do
    setup do
      @match = Haproxy2Rpm::SyslogHandler.new(self).parse_data(FIXTURE_SYSLOG_MESSAGE)
    end

    should 'match the priority' do
      assert_equal '12', @match[1]
    end

    should 'match  timestamp' do
      assert_equal "Jan  3 16:18:58", @match[2]
    end

    should 'match the hostname' do
      assert_equal "rechenschieber.local", @match[3]
    end

    should 'match the tag name' do
      assert_equal 'nodejs[36180]', @match[4]
    end

    should 'match the message' do
      assert_equal 'message', @match[5]
    end
  end
end
