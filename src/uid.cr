module UID
  VERSION = "0.1.0"
end

{% for i in (1..16) %}
struct UID{{ i }}
  include Comparable(UID{{ i }})
  @bytes : StaticArray(UInt8, {{ i }})

  def initialize(@bytes : StaticArray(UInt8, {{ i }}))
  end

  # Creates UUID from 16-bytes slice. Raises if *slice* isn't 16 bytes long
  def self.new(slice : Slice(UInt8))
    raise ArgumentError.new "Invalid bytes length #{slice.size}, expected 16" unless slice.size == {{ i }}

    bytes = uninitialized UInt8[{{ i }}]
    slice.copy_to(bytes.to_slice)

    new(bytes)
  end

  # Creates another `UUID` which is a copy of *uuid*
  def self.new(uuid : UUID)
    new(uuid.bytes)
  end

  # Creates new UUID by decoding `value` string from hyphenated (ie `ba714f86-cac6-42c7-8956-bcf5105e1b81`),
  # hexstring (ie `89370a4ab66440c8add39e06f2bb6af6`) or URN (ie `urn:uuid:3f9eaf9e-cdb0-45cc-8ecb-0e5b2bfb0c20`)
  # format, raising an `ArgumentError` if the string does not match any of these formats.
  def self.new(value : String)
    bytes = uninitialized UInt8[{{ i }}]

    if {{ i }} * 2 == value.size
      {{ i }}.times do |i|
        bytes[i] = hex_pair_at value, i * 2
      end
    else
      raise ArgumentError.new "Invalid string length #{value.size} for UUID, expected 32 (hexstring), 36 (hyphenated) or 45 (urn)"
    end

    new(bytes)
  end


  # Raises `ArgumentError` if string `value` at index `i` doesn't contain hex
  # digit followed by another hex digit.
  private def self.hex_pair_at(value : String, i) : UInt8
    hex_pair_at?(value, i) || raise ArgumentError.new "Invalid hex character at position #{i * 2} or #{i * 2 + 1}, expected '0' to '9', 'a' to 'f' or 'A' to 'F'"
  end

  # Parses 2 hex digits from `value` at index `i` and `i + 1`, returning `nil`
  # if one or both are not actually hex digits.
  private def self.hex_pair_at?(value : String, i) : UInt8?
    if (ch1 = value[i].to_u8?(16)) && (ch2 = value[i + 1].to_u8?(16))
      ch1 * 16 + ch2
    end
  end

  # Generates RFC 4122 v4 UUID.
  #
  # It is strongly recommended to use a cryptographically random source for
  # *random*, such as `Random::Secure`.
  def self.random(random : Random = Random::Secure) : self
    new_bytes = uninitialized UInt8[{{ i }}]
    random.random_bytes(new_bytes.to_slice)

    new(new_bytes)
  end

  # Generates an empty UUID.
  #
  # ```
  # UID.empty # => UID{{ i }}(00000000-0000-4000-0000-000000000000)
  # ```
  def self.empty : self
    new(StaticArray(UInt8, {{ i }}).new(0_u8))
  end

  # Returns the binary representation of the UUID.
  def bytes : StaticArray(UInt8, 16)
    @bytes.dup
  end

  # Returns unsafe pointer to 16-bytes.
  def to_unsafe
    @bytes.to_unsafe
  end

  # Convert to `String` in literal format.
  def inspect(io : IO) : Nil
    io << "UID" << {{ i }} << "("
    to_s(io)
    io << ')'
  end

  def to_s(io : IO) : Nil
    io << @bytes.to_slice.hexstring
  end

  def hexstring : String
    @bytes.to_slice.hexstring
  end

  def <=>(other : UUID) : Int32
    @bytes <=> other.bytes
  end

  class Error < Exception
  end
end
{% end %}
