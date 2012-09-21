$: << 'lib'
require 'minitest/autorun'
require_relative '../lib/feces'

class FecesTest < MiniTest::Unit::TestCase
  def client
    @client ||= Feces.connect 5000
  end

  def setup
    client.clear
  end

  def teardown
    client.quit
  end

  def test_set_get_strings
    client.set('str', 'ho')
    assert_equal 'ho', client.get('str')
  end

  def test_set_get_integers
    client.set('int', 123)
    assert_equal 123, client.get('int')
  end

  def test_set_get_arrays
    client.set('ary', [123, "hey"])
    assert_equal [123, "hey"], client.get('ary')
  end

  def test_delete
    client.set('int', 123)
    client.delete('int')
    assert_equal 'NOTFOUND', client.get('int')
  end

  def test_apush_apop_acount_aat
    client.apush('ary', 123)
    client.apush('ary', 999)
    assert_equal 999, client.aat('ary', 1)
    assert_equal 2, client.acount('ary')
    assert_equal 999, client.apop('ary')
    assert_equal 1, client.acount('ary')
  end

  def test_hset_hget
    client.hset('hash', 'foo', 123)
    assert_equal 123, client.hget('hash', 'foo')
  end
end