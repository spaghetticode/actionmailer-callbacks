module WorldExtensions
  def context_module
    @context_module ||= Module.new
  end
end

World(WorldExtensions)
