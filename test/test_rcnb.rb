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

  def test_cli
    bin_path=File.expand_path('../../bin/rcnb-rb',__FILE__)
    lib_path=File.expand_path('../../lib',__FILE__)
    test_path=File.expand_path('../',__FILE__)
    file_name_en='test_encode.txt'
    file_path_en=File.join(test_path,file_name_en)
    file_name_de='test_decode.txt'
    file_path_de=File.join(test_path,file_name_de)
    assert_equal 'ɌcńƁȓČņÞ',`ruby -I#{lib_path} #{bin_path} rcnb`
    # rcnb-rb rcnb => ɌcńƁȓČņÞ
    assert_equal 'rcnb',`ruby -I#{lib_path} #{bin_path} -d ɌcńƁȓČņÞ`
    # rcnb-rb -d ɌcńƁȓČņÞ => rcnb

    `ruby -I#{lib_path} #{bin_path} -d ȐȼŃƅȓčƞÞƦȻƝƃŖć > #{file_path_en}`
    # rcnb-rb -d ȐȼŃƅȓčƞÞƦȻƝƃŖć > test_encode.txt => Who NB?
    assert_equal 'Who NB?',IO.read(file_path_en)
    assert_equal 'ȐȼŃƅȓčƞÞƦȻƝƃŖć',`ruby -I#{lib_path} #{bin_path} -e -f #{file_path_en}`
    # rcnb-rb -e -f test_encode.txt => ȐȼŃƅȓčƞÞƦȻƝƃŖć

    `ruby -I#{lib_path} #{bin_path} RCNB! > #{file_path_de}`
    # rcnb-rb RCNB! > test_decode.txt => ȐĉņþƦȻƝƃŔć
    assert_equal 'ȐĉņþƦȻƝƃŔć',IO.read(file_path_de)
    assert_equal 'RCNB!',`ruby -I#{lib_path} #{bin_path} -d -f #{file_path_de}`
    # rcnb-rb -d -f test_decode.txt => RCNB!

    assert_equal 'ŅƁȒƇńßrćNƄŕčȐĉņþ',`ruby -I#{lib_path} #{bin_path} 流石RC`
    # rcnb-rb 流石RC => ŅƁȒƇńßrćNƄŕčȐĉņþ
    assert_equal 'ŇbŔƇÑƀRȻȐĉņþ',`ruby -I#{lib_path} #{bin_path} 流石RC -u SJIS`
    # rcnb-rb 流石RC -u SJIS => ŇbŔƇÑƀRȻȐĉņþ
    assert_equal 'ŇbŔƇÑƀRȻȐĉņþ',`ruby -I#{lib_path} #{bin_path} 流石RC --encoding SJIS`
    # rcnb-rb 流石RC --encoding SJIS => ŇbŔƇÑƀRȻȐĉņþ
    assert_equal '流石RC',`ruby -I#{lib_path} #{bin_path} -d ƝßřċŇþƦċȐĉņþ -u GBK`
    # rcnb-rb -d ƝßřċŇþƦċȐĉņþ -u GBK => 流石RC
    assert_equal '流石RC',`ruby -I#{lib_path} #{bin_path} -d ƝßřċŇþƦċȐĉņþ --encoding GBK`
    # rcnb-rb -d ƝßřċŇþƦċȐĉņþ --encoding GBK => 流石RC
  end

end