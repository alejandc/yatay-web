class CertificatePdf < Prawn::Document
  def initialize(certificate, view)
    super(top_margin: 70)
    @certificate = certificate
    @view = view
    order_number
  end
  
  def order_number
    text "Info Inicial", size: 30, style: :bold
  end
  
  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Product", "Qty", "Unit Price", "Full Price"]] +
    @order.line_items.map do |item|
      [item.name, item.quantity, price(item.unit_price), price(item.full_price)]
    end
  end
  
  def price(num)
    @view.number_to_currency(num)
  end

end

