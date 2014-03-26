# AmemberPro

A REST client for [aMember Pro Web API](http://www.amember.com/docs/REST)
This little gem should work against on aMember Pro 4.2.6

## Installation

Add this line to your application's Gemfile:

    gem 'amember_pro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amember_pro

## Usage

Intialize AmemberPro:

    AmemberPro(url, access_key)

Get Method:
    
    AmemberPro::Users.get # get a list users
    AmemberPro::Users.get({"_count" => 10, "_format" => "xml"}) # get 10 users and format is in xml, default format is json
    AmemberPro::Users.get({"_nested[]" => "invoices"}) # pulls together with invoices
    AmemberPro::Users.get({"_filter[name_f]" => "Gabino", "_filter[name_l]" => "Ang"}) # filter user with name Gabino Ang
    
Add Method:

    AmemberPro::Users.add({:login => "mylogin", :pass => "mypass", :name_f => "Gabino", :name_l => "Ang"})

Update Method:

    AmemberPro::Users.update(11, {:email => "gabino@ang.com"}) # update user's email address with id 11 

Delete Method:
    
    AmemberPro::Users.delete(13) # delete user with id 13

The above usage applies also to Invoices and Products API

## Check Access (special api)

Same as above after initialization of AmemberPro the following 
methods (by-login-pass, by-login, by-email) can be called:

    AmemberPro::CheckAcces.by_login_pass({:login => "mylogin", :pass => "mypass"})

Refer to this [document](http://www.amember.com/docs/REST) for all the parameters you can use

## Contributing

1. Fork it ( http://github.com/pyodor/amember_pro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
