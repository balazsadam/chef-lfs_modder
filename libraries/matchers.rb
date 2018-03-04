if defined?(ChefSpec)
  ChefSpec.define_matcher :modder

  def load_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:modder, :load, resource)
  end

  def remove_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:modder, :remove, resource)
  end


end
