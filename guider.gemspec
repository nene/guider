Gem::Specification.new do |s|
  s.required_rubygems_version = ">= 1.3.5"

  s.name = 'guider'
  s.version = '0.0.8'
  s.date = Time.new.strftime('%Y-%m-%d')
  s.summary = "Sencha guide generator"
  s.description = "JSDuck-compatible guides generator"
  s.homepage = "https://github.com/nene/guider"
  s.authors = ["Rene Saarsoo"]
  s.email = "rene.saarsoo@sencha.com"
  s.rubyforge_project = s.name

  # Add all soure-controlled files, except tests.
  s.files = `git ls-files`.split("\n").find_all do |file|
    file !~ /spec\//
  end

  s.executables = ["guider"]

  s.add_dependency 'kramdown', '>= 0.14.2'
  s.add_dependency 'json', '>= 1.7.5'

  s.require_path = 'lib'
end
