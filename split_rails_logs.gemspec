spec = Gem::Specification.new do |s|
  s.name = 'split_rails_logs'
  s.version = '1.0.0'
  s.licenses = ['MIT']
  s.summary = 'Split Rails logs across RSpec examples'
  s.authors = ["Nick Browne"]
  s.homepage = "https://github.com/nickbrowne/split_rails_logs"

  s.files = `git ls-files -- lib/*`.split("\n")

  s.add_dependency 'rspec-core', '>= 3.0'
  s.add_dependency 'rails', '>= 5.0'
  s.add_development_dependency 'rspec'
end
