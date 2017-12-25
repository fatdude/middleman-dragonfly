require "middleman-core"

Middleman::Extensions.register :dragonfly do
  require "middleman-dragonfly/extension"
  MiddlemanDragonfly
end
