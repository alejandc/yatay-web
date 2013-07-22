class CertificatePdf < Prawn::Document
  
  def initialize(certificate)
    super(page_size: "A4", page_layout: :landscape)
    @certificate = certificate
    generate_certificate
  end
  
  def generate_certificate
    # Encabezado del certificado
    data = [
            [{:content => "CERTIFICADO TECNICO \n RELOJ TAXIMETRO \n GOBIERNO DE LA CIUDAD DE BUENOS AIRES \n Resolución Nro. 261 - SPS - 95", :colspan => 3, :align => :center, :borders => [:top, :left, :right]}],
           ]
           
    # Datos fijos
    data += [
              [{:content => "Titular del registro: #{@certificate.registrant}", :colspan => 2},
               {:content => "Nro. Certificado \n Técnico \n #{@certificate.technical_certificate_number} \n ORIGINAL", :rowspan => 2, :align => :center}],

              [{:content => "Domicilio Comercial: #{@certificate.business_address}", :colspan => 2}],

              [{:content => "Nro. Ing. Brutos: \n #{@certificate.gross_income_number}"},
               {:content => "Nro. C.U.I.T.: \n #{@certificate.cuit}"}, 
               {:content => "Nro. Registro SSTy \n #{@certificate.registration_ssty_number}", :align => :center}],

              [{:content => "Habilitación: #{@certificate.habilitation}"},
               {:content => "Nro. Metrología Legal: #{@certificate.legal_metrology_number}"}, 
               {:content => "Fecha Emisión: \n #{@certificate.created_at.strftime('%d/%m/%Y')}", :align => :center}],

              [{:content => "", :colspan => 3}],

              [{:content => "Titular licencia de taxi: #{@certificate.titular}", :colspan => 3}],

              [{:content => "Documento tipo: #{@certificate.document_type}", :colspan => 1},
               {:content => "Documento Nro.: #{@certificate.document_number}", :colspan => 2}],

              [{:content => "Domicilio legal: #{@certificate.address}", :colspan => 3}],

              [{:content => "Licencia Taxi Nro.: #{@certificate.taxi_license_number}", :colspan => 1},
               {:content => "Marca Auto: #{@certificate.car_brand}", :colspan => 2}],

              [{:content => "Marca del reloj: \n #{@certificate.clock_brand}", :colspan => 1},
               {:content => "Modelo año: #{@certificate.car_model}", :colspan => 2}],
              
              [{:content => "Nro. de reloj: \n #{@certificate.clock_number}", :colspan => 1},
               {:content => "Dominio Nro.: #{@certificate.domain_number}", :colspan => 2}],
               
              [{:content => "Nro. Precinto: #{@certificate.precinct_number}", :colspan => 1, :rowspan => 2},
               {:content => "Nro. de Motor: #{@certificate.motor_number}", :colspan => 2}],
               
              [{:content => "Nro. de Chasis: #{@certificate.chasis_number}", :colspan => 2}],
              
              [{:content => "", :colspan => 3}],
              
              [{:content => "Trabajo Realizado / Observaciones: \n\n\n\n Pulsos por kilómetro:", :colspan => 3}],
              
              [{:content => "", :colspan => 3}],
              
              [{:content => "\n\n\n FIRMA Y ACLARACION \n TITULAR LICENCIA", :colspan => 1, :align => :center},
               {:content => "\n\n\n FIRMA Y SELLO DEL \n RESPONSABLE DEL TALLER", :colspan => 2, :align => :center}]
            ]
    
    table data, :column_widths => [120, 120, 120], :cell_style => {:size => 9}
    
    move_up 503
    table data, :column_widths => [120, 120, 120], :position => :right, :cell_style => {:size => 9}
  end
  
end

