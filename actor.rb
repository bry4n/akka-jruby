$:.unshift "lib"

require 'akka'

class ListenerA < Akka::Listener
  def onReceive(data)
    puts "ListenerA recieved: #{data}"
  end
end

class ListenerB < Akka::Listener
  def onReceive(data)
    puts "ListenerB recieved: #{data}"
  end
end

akka = Akka::AkkaActor.new
actor = akka.spawn ListenerA
actor2 = akka.spawn ListenerB

10.times do |i|
  actor.tell "Hello World #1 - #{i}"
end
actor2.tell "Hello World #2"

akka.stop
