# feces

Feces is a Ruby client for [ShitDB](https://github.com/txus/shitdb), a
crappy key-value store inspired by Redis.

Kudos to [@justinko](https://github.com/justinko) for this appropriate name.

## Installation

Add this line to your application's Gemfile:

    gem 'feces'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feces

## Usage

```ruby
require 'feces'
# Our ShitDB is running on port 4999
client = Feces.connect 4999
client.set('foo', [123, 'bar'])
client.apush('foo', 999)
client.get('foo')
# => [123, "bar", 999]
```

### Complete list of commands:

#### General

* `set(key, value)`
* `get(key)`
* `delete(key)`
* `clear`
* `quit`

#### Arrays

* `apush(key, value)`
* `apop(key)`
* `aat(key, index)`
* `acount(key)`

#### Hashes

* `hset(key, hkey, hvalue)`
* `hget(key, hkey)`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Who's this

This was made by [Josep M. Bach (Txus)](http://txustice.me) under the MIT
license. I'm [@txustice](http://twitter.com/txustice) on twitter (where you
should probably follow me!).
