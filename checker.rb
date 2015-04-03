class Checker

  attr_reader :good_lines, :bad_lines, :headers

  def initialize(good_lines={}, bad_lines={}, headers=[])
    @good_lines = good_lines
    @bad_lines = bad_lines
    @headers = headers
  end

  def add_good_lines
    @good_lines["name"] = "foo"
  end

  def add_bad_lines
    @bad_lines["name"] = "bar"
  end

  def add_columns_to_headers
    @headers << "something"
  end

end


checker = Checker.new

checker.add_good_lines
checker.add_bad_lines
checker.add_columns_to_headers

puts checker.good_lines
puts checker.bad_lines
puts checker.headers