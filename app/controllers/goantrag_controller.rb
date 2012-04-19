class GoantragController < ApplicationController
  def index
    puts "v v v index v v v"
    
    puts params.inspect
    dummyantrag = Dummyantrag.new(params["antrag"])
    dummyantrag.save
    
    puts "^ ^ ^ index ^ ^ ^"
    
  end

end
