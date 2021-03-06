require 'sinatra'

def get_birth_path_num(birthdate)
    number = 0
    (0..(birthdate.length - 1)).each do |i|
        number += birthdate[i].to_i
    end
    
    number = number.to_s
    number  = number[0].to_i + number[1].to_i
    
    if (number > 9)
        number = number.to_s
        number = number[0].to_i + number[1].to_i
    end
    return number
end

def message(birth_path_num)
    case birth_path_num
        when 1
        message = "Your numerology number is #{birth_path_num}.\nOne is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
        when 2
        message = "Your numerology number is #{birth_path_num}.\nThis is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
        when 3
        message = "Your numerology number is #{birth_path_num}.\nNumber Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
        when 4
        message = "Your numerology number is #{birth_path_num}.\nThis is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
        when 5
        message = "Your numerology number is #{birth_path_num}.\nThis is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
        when 6
        message = "Your numerology number is #{birth_path_num}.\nThis is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
        when 7
        message = "Your numerology number is #{birth_path_num}.\nThis is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
        when 8
        message = "Your numerology number is #{birth_path_num}.\nThis is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
        when 9
        message = "Your numerology number is #{birth_path_num}.\nThis is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
        else
        message = "Hmm ... something isn't adding up - you aren't any number from 1 to 9."
    end
end

get '/newpage' do
    @one = message(1)
    @two = message(2)
    @three = message(3)
    @four = message(4)
    @five = message(5)
    @six = message(6)
    @seven = message(7)
    @eight = message(8)
    @nine = message(9)
    erb :newpage
end

get '/:birthdate' do
    setup_index_view
end

get '/message/:birth_path_num' do
    birth_path_num = params[:birth_path_num].to_i
    @message = message(birth_path_num)
    erb :index
end

get '/' do
    erb :form
end

post '/' do
    birthdate = params[:birthdate].gsub("-","")
    if valid_birthdate(birthdate)
        birth_path_num = get_birth_path_num(birthdate)
        redirect "message/#{birth_path_num}"
        else
        @error = 'You should enter a valid birthdate in the form of mmddyyyy.'
        erb :form
    end
end

def setup_index_view
    birthdate = params[:birthdate]
    birth_path_num = get_birth_path_num(birthdate)
    @message = message(birth_path_num)
    erb :index
end

def valid_birthdate(input)
    if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
        return true
        else
        return false
    end
end