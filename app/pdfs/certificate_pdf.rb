class CertificatePdf < Prawn::Document
  
  def initialize(certificate)
    super(page_size: "A4", page_layout: :landscape, :top_margin => 50)
    @certificate = certificate
    @client = certificate.client
    generate_certificate
  end
  
  def generate_certificate
    # Encabezado del certificado
    data = get_certificate_header
    data += get_certificat_info("ORIGINAL")
    
    original = make_table data, :column_widths => [120, 120, 120], :cell_style => {:size => 8, :border_color => '939292'}
    
    table [[{:content => "", :background_color => '939292'}, original, {:content => "", :background_color => '939292'}],
           [{:content => "", :colspan => 3, :background_color => '939292'}]], :cell_style => {:border_color => '939292'}
    # Encabezado del certificado
    data = get_certificate_header
    data += get_certificat_info("DUPLICADO")
    
    duplicated = make_table data, :column_widths => [120, 120, 120], :cell_style => {:size => 8, :border_color => '939292'}
    
    move_up 496.5
    table [[{:content => "", :background_color => '939292'}, duplicated, {:content => "", :background_color => '939292'}],
           [{:content => "", :colspan => 3, :background_color => '939292'}]], :cell_style => {:border_color => '939292'}, :position => :right
  end
  
  def get_certificate_header
    [ 
      [{:content => "\n CERTIFICADO TECNICO \n RELOJ TAXIMETRO \n GOBIERNO DE LA CIUDAD DE BUENOS AIRES \n Resolución Nro. 261 - SPS - 95 \n\n",
         :colspan => 3, :size => 12, :align => :center, :borders => [:top, :left, :right], :font_style => :bold, :background_color => '939292', :size => 12}]
    ]
  end
  
  def get_certificat_info(value)
    [
      [{:content => "Titular del registro: #{@certificate.registrant} de Carlos Fernandez", :colspan => 2},
       {:content => "Nro. Certificado \n Técnico \n #{@certificate.technical_certificate_number} \n #{value}", :rowspan => 2, :align => :center}],

      [{:content => "Domicilio Comercial: #{@certificate.business_address}", :colspan => 2}],

      [{:content => "Nro. Ing. Brutos: \n #{@certificate.gross_income_number}"},
       {:content => "Nro. C.U.I.T.: \n #{@certificate.cuit}"}, 
       {:content => "Nro. Registro SSTy \n #{@certificate.registration_ssty_number}", :align => :center}],

      [{:content => "Habilitación: #{@certificate.habilitation}"},
       {:content => "Nro. Metrología Legal: #{@certificate.legal_metrology_number}"}, 
       {:content => "Fecha Emisión: \n #{@certificate.created_at.strftime('%d/%m/%Y')}", :align => :center, :font_style => :bold}],

      [{:content => "", :colspan => 3, :background_color => '939292'}],

      [{:content => "Titular licencia de taxi: #{@client.name}", :colspan => 3}],

      [{:content => "Documento tipo: #{@client.document_type}", :colspan => 1, :borders => [:top, :left, :bottom]},
       {:content => "Documento Nro.: #{@client.document_number}", :colspan => 2, :borders => [:top, :bottom, :right]}],

      [{:content => "Domicilio legal: #{@client.address}", :colspan => 3}],

      [{:content => "Licencia Taxi Nro.: #{@certificate.taxi_license_number}", :colspan => 1},
       {:content => "Marca Auto: #{@certificate.car_brand}", :colspan => 2}],

      [{:content => "Marca del reloj: \n #{@certificate.clock_brand}", :colspan => 1},
       {:content => "Modelo Auto: #{@certificate.car_model}", :colspan => 2}],
      
      [{:content => "Nro. de reloj: \n #{@certificate.clock_number}", :colspan => 1},
       {:content => "Dominio Nro.: #{@certificate.domain_number}", :colspan => 2}],
       
      [{:content => "Nro. Precinto: #{@certificate.precinct_number}", :colspan => 1, :rowspan => 2},
       {:content => "Nro. de Motor: #{@certificate.motor_number}", :colspan => 2}],
       
      [{:content => "Nro. de Chasis: #{@certificate.chasis_number}", :colspan => 2}],
      
      [{:content => "", :colspan => 3, :background_color => '939292'}],
      
      [{:content => "Trabajo Realizado / Observaciones: \n\n\n\n Pulsos por kilómetro: #{@certificate.pulses_per_km}", :colspan => 3}],
      
      [{:content => "", :colspan => 3, :background_color => '939292'}],
      
      [{:content => "\n\n\n FIRMA Y ACLARACION \n TITULAR LICENCIA", :colspan => 1, :align => :center, :borders => [:top, :left, :bottom]},
       {:content => "\n\n\n FIRMA Y SELLO DEL \n RESPONSABLE DEL TALLER", :colspan => 2, :align => :center, :borders => [:top, :bottom, :right]}]
    ]
  end
end

