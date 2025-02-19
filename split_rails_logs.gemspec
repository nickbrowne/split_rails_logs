spec = Gem::Specification.new do |s|
  s.name = 'split_rails_logs'
  s.version = '2.0.0'
  s.licenses = ['MIT']
  s.summary = 'Split Rails logs across RSpec examples'
  s.authors = ["Nick Browne"]
  s.homepage = "https://github.com/nickbrowne/split_rails_logs"

  s.files = `git ls-files -- lib/*`.split("\n")

  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'activesupport', '>= 7.1', '< 9'
  s.add_development_dependency 'rspec', '~> 3'
end
