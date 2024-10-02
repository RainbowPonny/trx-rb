# frozen_string_literal: true

module Trx
  module Abi
    class ContractEvent
      attr_accessor :name, :signature, :input_types, :inputs, :event_string, :address, :client

      def initialize(data)
        @name = data["name"]
        @input_types = data.fetch("inputs", []).map { |x| x["type"] }
        @inputs = data.fetch("inputs", []).map { |x| x["name"] }
        @event_string = "#{@name}(#{@input_types.join(",")})"
        @signature = Digest::Keccak.hexdigest(@event_string, 256)
      end

      def set_address(address)
        @address = address
      end

      def set_client(client)
        @client = client
      end
    end
  end
end
