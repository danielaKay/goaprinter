class BackofficeController < ApplicationController
  
  FILE_PREFIXES = {
    "go1" => "satzungs_aenderung",
    "go2" => "tagesordnungs_aenderung"
  }
  
  def index
    @antrags = Dummyantrag.find(:all)
  end

  def update
    puts params.inspect
    if params["id"] != nil
      puts "id present"
      @antrag = Dummyantrag.find(params["id"])
    end
    if params["antrag"] != nil
      puts "data present"
      @antrag = Dummyantrag.update(params["antrag"]["id"], params["antrag"])
      @antrag.save
    end
  end
  
  def print
    
    puts params.inspect
    
    puts "--" + params["id"] + "--"
    @antrag = Dummyantrag.find(params["id"])
    puts @antrag.inspect
    
    antrag_filename = FILE_PREFIXES[@antrag[:gotype]] + "-" + @antrag[:id].to_s + ".pdf";
    
    respond_to do | format | 
      format.pdf {
        headers['Content-Disposition'] = "attachment; filename=\"" + antrag_filename
        headers['Content-Type'] = "application/octet-stream"
        headers['Cache-Control'] = ""
        html = render_to_string(:layout => false , :action => "go-antrag.pdf.erb")
        kit = PDFKit.new(html)
        kit.stylesheets << Rails.root.join('app', 'assets', 'stylesheets', 'goantrag.css') #Rails.root +"assets/stylesheets/goantrag.css"
        
        send_data(kit.to_pdf, :filename => antrag_filename)        
      }
    end 

  end

end
