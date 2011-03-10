require "test/unit"

class TestBasic < Test::Unit::TestCase
  def test_rubygems
    assert_nothing_thrown("Checking for RubyGem") {
      require "rubygems"
    }
  end
  def test_sqlite3
    assert_nothing_thrown("Checking for SQLITE3 Library") {
      require 'rubygems'
      require 'sqlite3'
    }
  end
  def test_dbopen
    # Both rubygems and sqlite3 should be present by now, trying to open database

    assert_nothing_thrown("Checking if we can open database") {
      require 'rubygems'
      require 'sqlite3'
      db = SQLite3::Database.open("../sampledata/basic.sqlite")
    }
  end
end