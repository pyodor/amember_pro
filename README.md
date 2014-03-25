# AmemberPro

A REST client for aMember Pro Web API (http://www.amember.com/docs/REST)
This little gem should work against on aMember Pro 4.2.6

## Installation

Add this line to your application's Gemfile:

    gem 'amember_pro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amember_pro

## Usage

Intialize AmemberPro and provide aMember parameters:

    AmemberPro(url, access_key, [params]) # for params refer to aMember docs

Get or Add methods, the output depends on the params provided:

    AmemberPro::Users.get # get a list users
    AmemberPro::Users.add # add a user

Update or Delete, id is required

    AmemberPro::Users.update id
    AmemberPro::Users.delete id

The above usage applies also to Invoices and Products API

## Check Access (special api)

Same as above after initialization of AmemberPro the following 
methods (by-login-pass, by-login, by-email) can be called:

    AmemberPro::CheckAcces.by_login_pass


## Contributing

1. Fork it ( http://github.com/pyodor/amember_pro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
