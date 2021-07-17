require "optparse"
require File.expand_path("../../rcnb.rb",__FILE__)
require File.expand_path("../../rcnb/version.rb",__FILE__)

module RCNB
  # 命令行支持
  # 
  # 详见`rcnb-rb --help`
  # ## Example
  # ```bash
  # rcnb-rb Who NB?
  # => ȐȼŃƅȓčƞÞƦȻƝƃŖć
  # rcnb-rb -d ȐĉņþƦȻƝƃŔć
  # => RCNB!
  # ```
  # @since 0.3.0
  module CLI
    # 解析、处理命令行逻辑
    # @param args [Array] 待解析的命令行参数
    def self.parse(args)
      mode="encode"
      file_mode=false
      encoding=nil
      parser=OptionParser.new do |opt|
        opt.version=RCNB::VERSION
        opt.banner="使用方法：#{$PROGRAM_NAME} [-d|-e] [-u encoding] [-f] text"
        opt.on("-d","--decode","解码") { mode="decode" }
        opt.on("-e","--encode","编码（默认）") { mode="encode" }
        opt.on("-f","--file","把text当做文件路径") { file_mode=true }
        opt.on("-u VAL","--encoding VAL","指定文本编码（默认为utf-8）") { |val| encoding=val }
      end
      begin
        args=parser.parse args
      rescue
        puts parser.help
        return
      end

      text=args.join " "
      begin
        if file_mode
          text=IO.read(text).chomp
        end
      rescue
        puts "文件不存在的样子…"
        puts parser.help
        return
      end
      if !STDIN.tty?
        text+=STDIN.read.chomp
      end

      if mode=="decode"
        result=RCNB::decode(text,encoding)
      else
        result=RCNB::encode(text,encoding)
      end
      print result
    end
  end
end