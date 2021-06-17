# rcnb.rb

[![gem_shield](https://img.shields.io/gem/v/rcnb?color=%23fa0000)](https://rubygems.org/gems/rcnb)

A ruby implementation of [RCNB](https://github.com/rcnbapp/RCNB.js)

### Install

```bash
gem install rcnb
```

### Usage
```ruby
require 'rcnb'

RCNB.encode('Who NB?')
# => ȐȼŃƅȓčƞÞƦȻƝƃŖć
RCNB.decode('ȐĉņþƦȻƝƃŔć')
# => RCNB!
```

### Reference

[RCNB.js](https://github.com/rcnbapp/RCNB.js)   
[RCNB.py](https://github.com/chr233/RCNB.python)