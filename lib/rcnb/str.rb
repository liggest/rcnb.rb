require File.expand_path("../../rcnb.rb",__FILE__)

module RCNB

  # 字符串增强
  # ## Example
  # ```ruby
  # require 'rcnb/str'
  # using RCNB::Str
  # 
  # 'Who NB?'.rcnb
  # # => ȐȼŃƅȓčƞÞƦȻƝƃŖć
  # 'ȐĉņþƦȻƝƃŔć'.rcnb_decode
  # # => RCNB!
  # 'ȐĉņþƦȻƝƃŔć'.rcnb?
  # # => RCNB!
  # 'not rcnb'.rcnb?
  # # => nil
  # ```
  # @note 
  #   使用`using RCNB::Str`来细化String类
  # @since 0.2.0
  module Str
    # @!method rcnb(encoding=nil)
    #   将字符串编码为RCNB密文
    #   @!scope instance
    #   @param encoding 文本编码
    #   @return [String] 密文
    #
    # @!method rcnb_decode(encoding=nil)
    #   将RCNB密文字符串解码
    #   @!scope instance
    #   @param encoding 文本编码
    #   @return [String] 解码后的文本
    #
    # @!method rcnb?(encoding=nil)
    #   判断字符串是否为RCNB密文
    #   @!scope instance
    #   @param encoding 文本编码
    #   @return [String,nil] 若是RCNB密文，则返回解码结果，否则返回nil
    refine String do
      
      # 将字符串编码为RCNB密文
      # @param encoding 文本编码
      def rcnb(encoding=nil)
        RCNB.encode(self,encoding)
      end

      # 将RCNB密文字符串解码
      # @param encoding 文本编码
      def rcnb_decode(encoding=nil)
        RCNB.decode(self,encoding)
      end

      # 判断字符串是否为RCNB密文
      # @param encoding 文本编码
      # @return [String,nil] 若是RCNB密文，则返回解码结果，否则返回nil
      def rcnb?(encoding=nil)
        begin
          RCNB.decode(self,encoding)
        rescue ArgumentError
          nil
        end
      end

    end
  end
end