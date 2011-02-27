require 'test/unit'

class TestExecutable < Test::Unit::TestCase
  EXECUTABLE = 
  def test_complains_with_no_args
    output = %x{#{File.expand_path('../../bin/bushido', __FILE__)}}
    assert output =~ /See bushido -h for more detailed instructions/
  end
end

