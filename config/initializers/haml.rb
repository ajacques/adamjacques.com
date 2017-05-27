module HamlCompacter
  def parse_tag(line)
    result = super(line)
    unless result.size == 9 && [false, true].include?(result[4]) && [false, true].include?(result[5])
      raise "Unexpected parse_tag output: #{result.inspect}"
    end
    result[4] = true # nuke_outer_whitespace
    result[5] = true # nuke_inner_whitespace
    result
  end
end

Haml::Parser.send(:prepend, HamlCompacter) if ::Rails.env.production?
Haml::Template.options[:attr_wrapper] = '"'
