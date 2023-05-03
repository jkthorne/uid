# UID

Variable length `unique` ids based off the stdlib UUID implementation.

| Name  | bit length | value             |
|-------|------------|-------------------|
| UID1  | 8          | 255               |
| UID2  | 16         | 65,535            |
| UID3  | 24         | 16.8 million      |
| UID4  | 32         | 4.3 billion       |
| UID5  | 40         | 1.1 trillion      |
| UID6  | 48         | 281.5 trillion    |
| UID7  | 56         | 72.1 quadrillion  |
| UID8  | 64         | 18.4 quintillion  |
| UID9  | 72         | 4.7 sextillion    |
| UID10 | 80         | 1.2 septillion    |
| UID11 | 88         | 309.5 septillion  |
| UID12 | 96         | 79.2 octillion    |
| UID13 | 104        | 20.3 nonillion    |
| UID14 | 112        | 5.2 decillion     |
| UID15 | 120        | 1.3 undecillion   |
| UID16 | 128        | 340.3 undecillion |


This makes it easy to create a IDs for your specific needs.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     uid:
       github: jktorne/uid
   ```

2. Run `shards install`

## Usage

```crystal
require "uid"

p UID1.random

User.new(id: UID11.random)
```

## Contributing

1. Fork it (<https://github.com/jkthorne/uid/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jack Thorne](https://github.com/jkthorne) - creator and maintainer
