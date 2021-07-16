# rcnb.rb

[![gem_shield](https://img.shields.io/gem/v/rcnb?color=%23fa0000)](https://rubygems.org/gems/rcnb)

A ruby implementation of [RCNB](https://github.com/rcnbapp/RCNB.js)

### Install

```bash
gem install rcnb
```

### Usage
**Basic**
```ruby
require 'rcnb'

RCNB.encode('Who NB?')
# => ȐȼŃƅȓčƞÞƦȻƝƃŖć
RCNB.decode('ȐĉņþƦȻƝƃŔć')
# => RCNB!
```

**String Enhancement**

```ruby
require 'rcnb/str'
using RCNB::Str
 
'Who NB?'.rcnb
# => ȐȼŃƅȓčƞÞƦȻƝƃŖć
'ȐĉņþƦȻƝƃŔć'.rcnb_decode
# => RCNB!
'ȐĉņþƦȻƝƃŔć'.rcnb?
# => RCNB!
'not rcnb'.rcnb?
# => nil
```

### Reference

[RCNB.js](https://github.com/rcnbapp/RCNB.js)   
[RCNB.py](https://github.com/chr233/RCNB.python)