# Trx-rb

Small ruby gem to sign tron transactions and interact with api

This gem is not published to rubygems! 

## Usage

Generate transaction signature

```ruby
key_pair = Trx::Key.new(priv: 'your_rivate_key')
key_pair.sign(Trx::Utils.hex_to_bin('transaction_id'))
```

Interact with api

```ruby
client = Trx::HttpClient.new(Trx::HttpClient::MAINNET_HOST, trongrig_token: 'trongrid_token')
client.perform_command('walletsolidity/gettransactionbyid', JSON.generate({ value: 'xxxxxxxxxxxxxxxx' }))
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/darkponny/trx-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/darkponny/trx-rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Trx project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/darkponny/trx-rb/blob/master/CODE_OF_CONDUCT.md).
