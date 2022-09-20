require "byebug"
require_relative "room"

class Hotel
    def initialize (name, hash)
        @name = name
        @rooms = {}
        hash.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
        
     end 

    def rooms 
        @rooms
    end

    def name 
        words =  @name.split(" ")
        result = words.map {|word| word.capitalize}
        result.join(" ")
    end

    def room_exists?(room_name)
        return true if @rooms.keys.include?(room_name)
        false
    end 

    def check_in(person, room)
        if room_exists?(room)
            if @rooms[room].add_occupant(person)
                p "check in successful"
            else 
                p "sorry, room is full"
            end
        end
        p "sorry, room does not exist"
    end

    def has_vacancy?
        return false if @rooms.values.all?{|room|room.full?}
        true
    end

    def list_rooms
        @rooms.each do |room_name, room|
           puts room_name + room.available_space.to_s
        end
    end
end
