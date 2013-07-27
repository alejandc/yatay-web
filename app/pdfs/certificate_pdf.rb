class CertificatePdf < Prawn::Document
  
  def initialize(certificate)
    super(page_size: "A4", page_layout: :landscape, :top_margin => 10, :left_margin => 10, :right_margin => 10, :bottom_margin => 10)
    @certificate = certificate
    @client = certificate.client
    generate_certificate
  end
  
  def generate_certificate
    #Creamos el header del certificadocertificate
    header_table = make_table get_header_table, :column_widths => [125, 125, 125], :cell_style => {:size => 11, :border_color => '000000', :border_width => 2}
    static_content = make_table get_static_content("ORIGINAL"), :column_widths => [125, 125, 125]
    client_info = make_table get_client_info, :column_widths => [187, 187], :cell_style => {:size => 8, :border_color => 'D8D8D8'}
    
    table [ [{:content => "", :border_color => 'D8D8D8', :background_color => 'D8D8D8', :colspan => 3}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, header_table, {:content => " ", :border_color => '000000', :background_color => 'D8D8D8', :borders => [:left]}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, static_content, {:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, client_info, {:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}] ]
            
    
    move_up 558
    
    static_content = make_table get_static_content("DUPLICADO"), :column_widths => [125, 125, 125]
    
    table [ [{:content => "", :border_color => 'D8D8D8', :background_color => 'D8D8D8', :colspan => 3}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, header_table, {:content => " ", :border_color => '000000', :background_color => 'D8D8D8', :borders => [:left]}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, static_content, {:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}],
            [{:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}, client_info, {:content => " ", :border_color => 'D8D8D8', :background_color => 'D8D8D8'}] ], :position => :right
  end
  
  def get_header_table
    [ 
      [{:content => "\n CERTIFICADO TECNICO \n RELOJ TAXIMETRO \n GOBIERNO DE LA CIUDAD DE BUENOS AIRES \n Resolución Nro. 261 - SPS - 95 \n\n",
         :colspan => 3, :align => :center, :font_style => :bold, :background_color => 'D8D8D8', :size => 12, :borders => [:bottom, :top, :left, :right]}]
    ]
  end
  
  def get_static_content(value)
    [
      [{:content => "Titular del registro: #{@certificate.registrant} \n de Carlos Fernandez", :colspan => 2, :size =>8, :border_color => 'D8D8D8', :borders => [:left, :right, :bottom]},
       {:content => "Nro. Certificado \n Técnico", :align => :center, :borders => [:left, :right, :top], :size =>8, :border_color => 'D8D8D8', :borders => [:left, :right]}],

      [{:content => "Domicilio Comercial: #{@certificate.business_address}", :colspan => 2, :size =>8, :border_color => 'D8D8D8'},
       {:content => "#{@certificate.get_technical_certificate_number} \n #{value}", :size =>10, :valign => :top, :font_style => :bold, :align => :center, :border_color => 'D8D8D8', :borders => [:left, :right, :bottom]}],

      [{:content => "Nro. Ing. Brutos: \n #{@certificate.gross_income_number}", :colspan => 1, :size =>8, :border_color => 'D8D8D8'},
       {:content => "Nro. C.U.I.T.: \n #{@certificate.cuit}", :colspan => 1, :size =>8, :border_color => 'D8D8D8'}, 
       {:content => "Nro. Registro SSTy \n #{@certificate.registration_ssty_number}", :align => :center, :colspan => 1, :size =>8, :border_color => 'D8D8D8'}],

      [{:content => "Habilitación: #{@certificate.habilitation}", :colspan => 1, :size =>8, :border_color => 'D8D8D8'},
       {:content => "Nro. Metrología Legal: #{@certificate.legal_metrology_number}", :colspan => 1, :size =>8, :border_color => 'D8D8D8'}, 
       {:content => "Fecha Emisión: \n #{@certificate.created_at.strftime('%d/%m/%Y')}", :align => :center, :font_style => :bold, :colspan => 1, :size => 10, :border_color => 'D8D8D8'}]
    ]
  end
  
  def get_client_info
    [
      [{:content => "", :colspan => 2, :background_color => 'D8D8D8'}],
      
      [{:content => "Titular licencia de taxi: #{@client.name}", :colspan => 2}],

      [{:content => "Documento tipo: #{@client.document_type}", :colspan => 1, :borders => [:top, :left, :bottom]},
       {:content => "Documento Nro.: #{@client.document_number}", :colspan => 1, :borders => [:top, :bottom, :right]}],

      [{:content => "Domicilio legal: #{@client.address} C.A.B.A.", :colspan => 2}],

      [{:content => "Licencia Taxi Nro.: #{@certificate.taxi_license_number}", :colspan => 1},
       {:content => "Marca Auto: #{@certificate.car_brand}", :colspan => 1}],

      [{:content => "Marca del reloj:  #{@certificate.clock_brand}", :colspan => 1},
       {:content => "Modelo Auto: #{@certificate.car_model}", :colspan => 1}],
      
      [{:content => "Nro. de reloj: #{@certificate.clock_number}", :colspan => 1},
       {:content => "Dominio Nro.: #{@certificate.domain_number}", :colspan => 1}],
       
      [{:content => "Nro. Precinto: #{@certificate.precinct_number}", :colspan => 1, :rowspan => 2},
       {:content => "Nro. de Motor: #{@certificate.motor_number}", :colspan => 1}],
       
      [{:content => "Nro. de Chasis: #{@certificate.chasis_number}", :colspan => 1}],
      
      [{:content => "", :colspan => 2, :background_color => 'D8D8D8'}],
      
      [{:content => "Trabajo Realizado / Observaciones: \n\n\n\n", :colspan => 2, :borders => [:left, :top, :right]}],
      
      [{:content => "Pulsos por kilómetro:", :colspan => 1, :borders => [:left, :bottom]},
       {:content => "#{@certificate.pulses_per_km}", :colspan => 1, :borders => [:right, :bottom]}],
      
      [{:content => "", :colspan => 2, :background_color => 'D8D8D8'}],
      
      [{:content => "\n\n\n\n\n FIRMA Y ACLARACION \n TITULAR LICENCIA", :colspan => 1, :align => :center, :borders => [:top, :left, :bottom]},
       {:content => "\n\n\n\n\n FIRMA Y SELLO DEL \n RESPONSABLE DEL TALLER", :colspan => 1, :align => :center, :borders => [:top, :bottom, :right]}],
       
      [{:content => "", :colspan => 2, :background_color => 'D8D8D8'}],
    ]
  end
end

