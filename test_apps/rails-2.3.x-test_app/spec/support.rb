def preserve_envs(*keys, &block)
  cache = {}
  keys.each { |key| cache[key] = ENV[key] }

  begin
    yield
  ensure
    keys.each { |key| ENV[key] = cache[key] }
  end
end
