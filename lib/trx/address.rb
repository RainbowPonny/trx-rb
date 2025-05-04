# frozen_string_literal: true

module Trx
  class Address
    ADDRESS_PREFIX = "41"

    def self.from_public_hex(public_hex)
      raise ArgumentError, "Expected String, got #{public_hex.class}" unless public_hex.is_a?(String)

      bytes = Utils.hex_to_bin(public_hex)
      address_bytes = Utils.keccak256(bytes[1..-1])[-20..-1]
      prefixed_address_hex = ADDRESS_PREFIX + RLP::Utils.encode_hex(address_bytes)
      prefixed_address_bytes = Utils.hex_to_bin(prefixed_address_hex)
      checksum = Utils.base58check(prefixed_address_bytes).hexdigest[0..7]
      base58check_adress = Base58.encode_hex(prefixed_address_hex + checksum)

      Address.new(base58check_adress)
    end

    attr_reader :address

    def initialize(address)
      raise ArgumentError, "Expected String, got #{address.class}" unless address.is_a?(String)

      @address = Utils.prefix_hex(address.delete("\s"))
    end

    def valid_base58?(str)
      !!(str =~ /\A[1-9A-HJ-NP-Za-km-z]+\z/)
    end

    def checksum_matches?
      return false unless valid_base58?(address)

      computed_checksum = Utils.sha256(
        Utils.sha256(to_bytes).digest
      ).hexdigest[0..7]

      checksum_hex == computed_checksum
    end
    alias_method :valid?, :checksum_matches?

    def to_bytes
      Utils.hex_to_bin(to_base58_decode_hex)[0..-5]
    end

    def to_base58_decode_hex
      Utils.base58_decode_hex(address)
    end

    def to_hex
      Utils.base58_decode_hex(address)[0..-9]
    end

    def to_s
      Utils.remove_hex_prefix(address)
    end

    private

    def checksum_bytes
      bytes[0..3]
    end

    def checksum_hex
      to_base58_decode_hex[-8..-1]
    end
  end
end
