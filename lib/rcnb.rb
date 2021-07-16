
# # rcnb
# A ruby implementation of RCNB
# ---

# RCNB模块
# 
# ## Example
# ```ruby
# require 'rcnb'
# 
# RCNB.encode('Who NB?')
# # => ȐȼŃƅȓčƞÞƦȻƝƃŖć
# RCNB.decode('ȐĉņþƦȻƝƃŔć')
# # => RCNB!
# ```
module RCNB
  # @private
  # :stopdoc:
  CR=:rRŔŕŖŗŘřƦȐȑȒȓɌɍ
  # @private
  CC=:cCĆćĈĉĊċČčƇƈÇȻȼ
  # @private
  CN=:nNŃńŅņŇňƝƞÑǸǹȠȵ
  # @private
  CB=:bBƀƁƃƄƅßÞþ

  def self.getIndexHash(s)
    s=s.to_s unless s.is_a? String
    Hash[s.each_char.with_index.to_a]
  end

  private_class_method :getIndexHash
  # @private
  IR=getIndexHash(CR)
  # @private
  IC=getIndexHash(CC)
  # @private
  IN=getIndexHash(CN)
  # @private
  IB=getIndexHash(CB)

  # @private
  SR=CR.size
  # @private
  SC=CC.size
  # @private
  SN=CN.size
  # @private
  SB=CB.size

  # @private
  SRC=SR*SC
  # @private
  SNB=SN*SB
  # @private
  SCNB=SC*SNB
  # :startdoc:

  def self.encodeByte(i)
    raise ArgumentError,'rc/nb overflow' if i>0xFF
    if i>0x7F
      i&=0x7F
      d,m=i.divmod(SB)
      "#{CN[d]}#{CB[m]}"
    else
      d,m=i.divmod(SC)
      "#{CR[d]}#{CC[m]}"
    end
  end

  def self.encodeShort(i)
    raise ArgumentError,'rc/nb overflow' if i>0xFFFF
    reverse=false
    if i>0x7FFF
      i&=0x7FFF
      reverse=true
    end
    result=[
      CR[i/SCNB],
      CC[i%SCNB/SNB],
      CN[i%SNB/SB],
      CB[i%SB]
    ]
    result=[ result[2],result[3],result[0],result[1] ] if reverse
    result.join
  end

  def self.decodeByte(c)
    nb=false
    idx=[ IR[c[0]],IC[c[1]] ]
    if !idx.all?
      nb=true
      idx=[ IN[c[0]],IB[c[1]] ]
    end
    raise ArgumentError,'not rc/nb' if !idx.all?
    result=nb ? idx[0]*SB+idx[1] : idx[0]*SC+idx[1]
    raise ArgumentError,'rc/nb overflow' if result>0x7F
    nb ? result|0x80 : result
  end

  def self.decodeShort(c)
    reverse=!IR[c[0]]
    if reverse
      idx=[ IR[c[2]],IC[c[3]],IN[c[0]],IB[c[1]] ]
    else
      idx=[ IR[c[0]],IC[c[1]],IN[c[2]],IB[c[3]] ]
    end
    raise ArgumentError,'not rc/nb' if !idx.all?
    result=idx[0]*SCNB+idx[1]*SNB+idx[2]*SB+idx[3]
    raise ArgumentError,'rc/nb overflow' if result>0x7FFF
    reverse ? result|0x8000 : result
  end

  private_class_method :encodeByte,:encodeShort,:decodeByte,:decodeShort

  # @@encoding='utf-8'
  # def self.defaultEncoding
  #   @@encoding || __ENCODING__.name
  # end

  # def self.defaultEncoding=(encoding)
  #   @@encoding=encoding
  # end

  # 将文本编码为RCNB密文
  # @param str [String] 文本
  # @param encoding 文本编码
  # @return [String] 密文
  def self.encode(str,encoding=nil)
    str=str.encode(encoding) if encoding
    arr=str.unpack('C*')
    result=''
    0.upto( (arr.size>>1)-1 ) do |i|
      i2=i*2
      result+=encodeShort( arr[i2]<<8 | arr[i2+1] )
    end
    result+=encodeByte(arr[arr.size-1]) unless (arr.size & 1).zero?
    result
  end

  # 将RCNB密文解码为文本
  # @param str [String] 密文
  # @param encoding 文本编码
  # @return [String] 文本
  def self.decode(str,encoding=nil)
    raise ArgumentError,'invalid length' unless (str.size & 1).zero?
    arr=[]
    0.upto( (str.size>>2)-1 ) do |i|
      i4=i*4
      short=decodeShort(str[i4,4])
      arr<< (short>>8)
      arr<< (short&0xFF)
    end
    arr<< decodeByte(str[-2,2]) unless (str.size & 2).zero?
    result=arr.pack('C*')
    if encoding
      result=result.force_encoding(encoding)
      result=result.encode(__ENCODING__)
    else
      result=result.force_encoding(__ENCODING__)
    end
    result
  end

end