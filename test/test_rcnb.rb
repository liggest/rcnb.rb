require 'minitest/autorun'
require 'rcnb'

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
end