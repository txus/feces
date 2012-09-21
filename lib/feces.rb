require 'socket'
require_relative "feces/version"

module Feces
  def self.connect(port=4999)
    socket = TCPSocket.new('localhost', port)
    Client.new(socket)
  end

  class Client
    def initialize(socket)
      @socket = socket
    end

    def set(key, value)
      emit "SET #{key} #{s value}"
      expect "OK"
    end

    def get(key)
      emit "GET #{key}"
      receive
    end

    def apush(key, value)
      emit "APUSH #{key} #{s value}"
      expect "OK"
    end

    def acount(key)
      emit "ACOUNT #{key}"
      receive
    end

    def aat(key, index)
      emit "AAT #{key} #{index}"
      receive
    end

    def apop(key)
      emit "APOP #{key}"
      receive
    end

    def hset(key, hkey, hvalue)
      emit "HSET #{key} #{hkey} #{s hvalue}"
      expect "OK"
    end

    def hget(key, hkey)
      emit "HGET #{key} #{hkey}"
      receive
    end

    def delete(key)
      emit "DELETE #{key}"
      expect "OK"
    end

    def clear
      emit "CLEAR"
      expect "OK"
    end

    def quit
      emit "QUIT"
    end

    private

    def s(value)
      value.inspect.gsub(' ','')
    end

    def emit(str)
      @socket.write "#{str}\n"
    end

    def receive
      case res = @socket.readline.chomp.gsub(?\x00, '')
      when /^\d+/
        res.to_i
      when /^\"/
        res[1..-2]
      when /^\[/
        eval(res)
      else
        res
      end
    end

    def expect(str)
      val = receive
      raise "Expected #{str}, got #{val.inspect}" unless val == str
    end
  end
end
