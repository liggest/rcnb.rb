require 'minitest/autorun'
require 'rcnb'

require 'rcnb/str'
using RCNB::Str

class RCNBTest < Minitest::Test
  def test_encode
    assert_equal 'ɌcńƁȓČņÞ',RCNB.encode('rcnb')
    assert_equal 'ȐȼŃƅȓčƞÞƦȻƝƃŖć',RCNB.encode('Who NB?')
  end

  def test_decode
    assert_equal 'rcnb',RCNB.decode('ɌcńƁȓČņÞ')
    assert_equal 'RCNB!',RCNB.decode('ȐĉņþƦȻƝƃŔć')
  end

  def test_encoding
    assert_equal 'ŅƁȒƇńßrćNƄŕčȐĉņþ',RCNB.encode('流石RC')
    assert_equal 'ŇbŔƇÑƀRȻȐĉņþ',RCNB.encode('流石RC',encoding='SJIS')
    assert_equal 'ƝßřċŇþƦċȐĉņþ',RCNB.encode('流石RC',encoding='GBK')
    assert_equal '流石RC',RCNB.decode('ŅƁȒƇńßrćNƄŕčȐĉņþ')
    assert_equal '流石RC',RCNB.decode('ŇbŔƇÑƀRȻȐĉņþ',encoding='SJIS')
    assert_equal '流石RC',RCNB.decode('ƝßřċŇþƦċȐĉņþ',encoding='GBK')
  end

  def test_str
    assert_equal 'ɌcńƁȓČņÞ','rcnb'.rcnb
    assert_equal 'ȐȼŃƅȓčƞÞƦȻƝƃŖć','Who NB?'.rcnb
    assert_equal 'rcnb','ɌcńƁȓČņÞ'.rcnb_decode
    assert_equal 'RCNB!','ȐĉņþƦȻƝƃŔć'.rcnb_decode
    assert_equal 'rcnb','ɌcńƁȓČņÞ'.rcnb?
    assert_nil   'not rcnb'.rcnb?
  end
end