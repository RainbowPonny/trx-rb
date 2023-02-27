require 'spec_helper'

describe Trx::Abi do
  let(:abi) {
    [
      {
        "inputs": [
          {
            "name" => "_greeting",
            "type" => "string"
          }
        ],
        "payable" => false,
        "type" => "constructor"
      },
      {
        "inputs" => [],
        "name" => "getCount",
        "outputs" => [
          {
            "internalType" => "uint256",
            "name" => "count",
            "type" => "uint256"
          }
        ],
        "stateMutability" => "view",
        "type" => "function"
      },
      {
        "inputs" => [],
        "name" => "increment",
        "outputs" => [],
        "stateMutability" => "nonpayable",
        "type" => "function"
      },
      {
        "inputs" => [],
        "name" => "increment",
        "outputs" => [],
        "stateMutability" => "nonpayable",
        "type" => "constructor"
      }
    ]
  }

  it "parses abi" do
    constructor_inputs, functions, events = Trx::Abi::parse_abi(abi)

    expect(functions[0].name).to eq "getCount"
    expect(functions[1].outputs[0].type).to eq "count"
    expect(constructor_inputs[0].name).to eq "_greeting"
    expect(constructor_inputs[0].type).to eq "string"
  end
end
