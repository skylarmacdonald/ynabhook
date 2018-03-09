require 'rubygems'
require 'sinatra/base'
require 'dotenv'
require 'net/http'
require 'uri'
require 'json'
require 'date'

class YNABHook < Sinatra::Base
  header = {'Content-Type': 'text/json', 'Authorization': "Bearer #{ENV['YNAB_KEY']}"}

  post '/monzo' do
    if params[:type] == 'transaction.created'
      uri = URI.parse("https://api.youneedabudget.com/v1/budgets/#{ENV['BUDGET_ID']}/transactions")
      http = Net::HTTP.new(uri.host, uri.port)
      txn = {
        "transaction": {
          "account_id": ENV['MONZO_ACCOUNT_ID'],
          "date": DateTime.iso8601(params[:data][:created]).strftime('%F'),
          "amount": params[:data][:amount]*10,
          "payee_id": nil,
          "payee_name": params[:data][:description],
          "category_id": nil,
          "memo": nil,
          "cleared": "cleared",
          "approved": true,
          "flag_color": nil,
          "import_id": params[:data][:id]
        }
      }
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = txn.to_json
      response = http.request(request)
    end
  end

end
