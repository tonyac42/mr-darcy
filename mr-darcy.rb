require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

account_sid = "AC6b789bf8d90e27072b0180533678ea35"
auth_token = "988e630c11f554607c4c7f61a18a3e43"

proposal = false

@client = Twilio::REST::Client.new(account_sid, auth_token)

get '/' do
  puts 'Hello World'
end

message = @client.api.account.messages.create(
  :from => "+12019285517",
  :to =>"+17165481917",
  :body => "Is Mr. Darcy ever wrong? Answer: 1-For Yes and 2-For No."
)

# send a dynamic reply to incoming text message
post '/sms' do
  # transform request body to lowercase
  body = params['Body'].downcase

  # Build response based on given body param
  twiml = Twilio::TwiML::MessagingResponse.new do |resp|
    if body == '1'
      resp.message body: 'Good'
    elsif body == '2'
      resp.message body: 'Bad!'
    end
  end

  twiml.to_s
end
