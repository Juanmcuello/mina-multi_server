Gem::Specification.new do |s|
  s.author   = ['Juan Manuel Cuello']
  s.files    = `git ls-files`.split("\n")
  s.email    = 'juanmacuello@gmail.com'
  s.homepage = 'https://github.com/Juanmcuello/mina-multi_server'
  s.license  = 'MIT'
  s.name     = 'mina-multi_server'
  s.require_paths = ['lib', 'tasks']
  s.summary  = 'Mina multi-server support'
  s.version  = '0.0.2'

  s.add_dependency 'mina', '~> 1.0'
end
