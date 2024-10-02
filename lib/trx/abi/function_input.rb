# frozen_string_literal: true

module Trx
  module Abi
    class FunctionInput
      attr_accessor :type, :name

      def initialize(data)
        @type = data["type"]
        @name = data["name"]
      end
    end
  end
end
