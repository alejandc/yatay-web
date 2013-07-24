class CertificatePdf < Prawn::Document
  
  def initialize(certificate)
    super(page_size: "A4", page_layout: :landscape, :top_margin => 50, :left_margin => 28, :right_margin => 28)
    @certificate = certificate
    @client = certificate.client
    generate_certificate
  end
  
  def generate_certificate
    #Creamos el header del certificado
    header_table = make_table get_header_table, :column_widths => [130, 130, 130], :cell_style => {:size => 10, :border_color => '939292'}
    static_content = make_table get_static_content("ORIGINAL"), :column_widths => [130, 130, 130], :cell_style => {:size => 8, :border_color => '939292'}
    client_info = make_table get_client_info, :column_widths => [195, 195], :cell_style => {:size => 8, :border_color => '939292'}
    
    table [ [header_table],
            [static_content],
            [client_info] ], :column_widths => [390], :cell_style => {:border_color => '939292', :border_width => 5}
            
    
    move_up 496
    
    static_content = make_table get_static_content("DUPLICADO"), :column_widths => [130, 130, 130], :cell_style => {:size => 8, :border_color => '939292'}
    table [ [header_table],
            [static_content],
            [client_info] ], :position => :right, :column_widths => [390], :cell_style => {:border_color => '939292', :border_width => 5}
  end
  
  def get_header_table
    [ 
      [{:content => "\n CERTIFICADO TECNICO \n RELOJ TAXIMETRO \n GOBIERNO DE LA CIUDAD DE BUENOS AIRES \n Resolución Nro. 261 - SPS - 95 \n\n",
         :colspan => 3, :align => :center, :font_style => :bold, :background_color => '939292', :size => 12}]
    ]
  end
  
  def get_static_content(value)
    [
      [{:content => "Titular del registro: #{@certificate.registrant} \n de Carlos Fernandez", :colspan => 2},
       {:content => "Nro. Certificado \n Técnico \n #{@certificate.technical_certificate_number} \n #{value}", :rowspan => 2, :align => :center}],

      [{:content => "Domicilio Comercial: #{@certificate.business_address}", :colspan => 2}],

      [{:content => "Nro. Ing. Brutos: \n #{@certificate.gross_income_number}", :colspan => 1},
       {:content => "Nro. C.U.I.T.: \n #{@certificate.cuit}", :colspan => 1}, 
       {:content => "Nro. Registro SSTy \n #{@certificate.registration_ssty_number}", :align => :center, :colspan => 1}],

      [{:content => "Habilitación: #{@certificate.habilitation}", :colspan => 1},
       {:content => "Nro. Metrología Legal: #{@certificate.legal_metrology_number}", :colspan => 1}, 
       {:content => "Fecha Emisión: \n #{@certificate.created_at.strftime('%d/%m/%Y')}", :align => :center, :font_style => :bold, :colspan => 1}]
    ]
  end
  
  def get_client_info
    [
      [{:content => "Titular licencia de taxi: #{@client.name}", :colspan => 2}],

      [{:content => "Documento tipo: #{@client.document_type}", :colspan => 1, :borders => [:top, :left, :bottom]},
       {:content => "Documento Nro.: #{@client.document_number}", :colspan => 1, :borders => [:top, :bottom, :right]}],

      [{:content => "Domicilio legal: #{@client.address} C.A.B.A.", :colspan => 2}],

      [{:content => "Licencia Taxi Nro.: #{@certificate.taxi_license_number}", :colspan => 1},
       {:content => "Marca Auto: #{@certificate.car_brand}", :colspan => 1}],

      [{:content => "Marca del reloj: \n #{@certificate.clock_brand}", :colspan => 1},
       {:content => "Modelo Auto: #{@certificate.car_model}", :colspan => 1}],
      
      [{:content => "Nro. de reloj: \n #{@certificate.clock_number}", :colspan => 1},
       {:content => "Dominio Nro.: #{@certificate.domain_number}", :colspan => 1}],
       
      [{:content => "Nro. Precinto: #{@certificate.precinct_number}", :colspan => 1, :rowspan => 2},
       {:content => "Nro. de Motor: #{@certificate.motor_number}", :colspan => 1}],
       
      [{:content => "Nro. de Chasis: #{@certificate.chasis_number}", :colspan => 1}],
      
      [{:content => "", :colspan => 2, :background_color => '939292'}],
      
      [{:content => "Trabajo Realizado / Observaciones: \n\n\n\n Pulsos por kilómetro: #{@certificate.pulses_per_km}", :colspan => 2}],
      
      [{:content => "", :colspan => 2, :background_color => '939292'}],
      
      [{:content => "\n\n\n FIRMA Y ACLARACION \n TITULAR LICENCIA", :colspan => 1, :align => :center, :borders => [:top, :left, :bottom]},
       {:content => "\n\n\n FIRMA Y SELLO DEL \n RESPONSABLE DEL TALLER", :colspan => 1, :align => :center, :borders => [:top, :bottom, :right]}]
    ]
  end
end

