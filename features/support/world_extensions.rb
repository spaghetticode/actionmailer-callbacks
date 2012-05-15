module WorldExtensions
  attr_accessor :code_result

  def context_module
    @context_module ||= Module.new
  end
end

World(WorldExtensions)
