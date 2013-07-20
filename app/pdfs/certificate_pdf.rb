class CertificatePdf < Prawn::Document
  
  def initialize(certificate)
    super(page_size: "A4", page_layout: :landscape)
    @certificate = certificate
    generate_certificate
  end
  
  def generate_certificate
    # Encabezado del certificado
    data = [
            [{:content => "CERTIFICADO TECNICO \n RELOJ TAXIMETRO", :colspan => 3, :align => :center, :borders => [:top, :left, :right]}],
            [{:content => "GOBIERNO DE LA CIUDAD DE BUENOS AIRES", :colspan => 3, :align => :center, :borders => [:left, :right]}],
            [{:content => "Resolución Nro. 261 - SPS - 95", :colspan => 3, :align => :center, :borders => [:left, :right, :bottom]}]
           ]
           
    #TODO hacer incremental el numero del certificado texnico...
    # Datos fijos
    data += [
             [{:content => "Titular del registro: \n #{@certificate.titular}", :colspan => 2},
              {:content => "Nro. Certificado \n Técnico \n 001233 \n\n ORIGINAL", :rowspan => 2, :align => :center}],
              
             [{:content => "Domicilio Comercial: \n #{@certificate.business_address}", :colspan => 2}],
             
             [{:content => "Nro. Ing. Brutos: \n #{@certificate.gross_income_number}"},
              {:content => "Nro. C.U.I.T.: \n #{@certificate.cuit}"}, 
              {:content => "Nro. Registro SSTy \n #{@certificate.registration_ssty_number}", :align => :center}]
            ]
    
    table data, :column_widths => [120, 120, 120]
    
    #move_up 155.5
    #table data, :column_widths => [120, 120, 120], :position => :right
  end
  
end

