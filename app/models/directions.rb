class Directions
  attr_reader :distance, :duration, :instructions

  def initialize(info)
    @distance = info[:distance][:text]
    @duration = info[:duration][:text]
    @instructions = format_instructions(info[:steps])
  end


  def format_instructions(steps)
    steps.map do |step|
      step[:html_instructions]
    end.join(', ')
  end
end
