require 'pusher-client'
require 'nexmo'
require 'json'

client = Nexmo::Client.new(
  key: "03e7fcef",
  secret: "a7ba1fe42e5ca20a"
)

to_number = "14106967262"
subreddit = 'askreddit'

puts "What is your phone number?"
to_number = "1#{gets.chomp}"
puts "What subreddit?"
subreddit = gets.chomp

socket = PusherClient::Socket.new("50ed18dd967b455393ed")

socket.subscribe(subreddit)

socket[subreddit].bind('new-listing') do |data|
    puts data
    json = JSON.parse(data)
    title = json['title']
    url = json['url']
    response = client.send_message(
        from: "12028527004",
        to: to_number,
        text: "Hello! There is a new post in " + subreddit + "! Post title: " + title
        )
    sleep(1)
    response2 = client.send_message(
        from: "12028527004",
        to: to_number,
        text: "Link to post: " + url
        )
    puts response
    puts response2
end

socket.connect