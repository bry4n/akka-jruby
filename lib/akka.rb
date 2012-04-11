$:.unshift *["vendor/akka/lib", "vendor/akka/lib/akka"]

require 'java'
require 'scala-library'
require 'akka-actor-2.0'

module Akka

  include_package 'akka.actor'

  java_import 'akka.actor.Props'
  java_import 'com.typesafe.config.ConfigFactory'

  
  class AkkaActor

    def initialize(name = "AkkaActor")
      @system = Akka::ActorSystem.create(name)
    end

    def spawn(listener)
      factory = Akka::ActorFactory.new(listener)
      @system.actorOf(Props.new(factory))
    end

    def stop
      @system.shutdown
    end
  
  end
  
  class Listener < Akka::UntypedActor; end

  class ActorFactory < Struct.new(:listener)
    #include Akka::UntypedActorFactory

    def create
      listener.new
    end

  end

  class Config
    
    def initialize(file)
      @config = Akka::ConfigFactory.parseString(File.read(file))
    end
    
    def load
      Akka::ConfigFactory.load(@config)
    end

  end

end


