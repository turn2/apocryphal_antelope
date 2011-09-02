module TransformHelpers
  def ordinal_to_i(ordinal)
    ords = %w(first second third fourth fifth)
    map = Hash[*ords.zip([*(1..ords.length)]).flatten]
    map[ordinal]
  end
  
  def convert_headers_to_attr_names!(table)
    table.map_headers! { |header| header.downcase.tr(' ', '_').to_sym }
  end
end

Transform /^listed (\w+)$/ do |ord_str|
  ordinal_to_i(ord_str)
end

World(TransformHelpers)