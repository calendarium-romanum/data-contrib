require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

LANGUAGES = {
  'czechRepublic' => 'cs',
  'france' => 'fr',
  'italy' => 'it',
  'poland' => 'pl',
  'slovakia' => 'sk',
}
ALL_LANGUAGES = LANGUAGES.values.uniq

# in which languages to generate the given calendar
def languages_for(path)
  name = File.basename(path).sub(/\.js$/, '')

  return ALL_LANGUAGES if name == 'general'

  r = ['en']
  r << LANGUAGES[name] if LANGUAGES[name]
  r
end

romcal_export_targets =
  Dir['node_modules/romcal/dist/calendars/*.js']
    .reject {|s| s.end_with? 'index.js' }
    .flat_map {|s| languages_for(s).collect {|l| [s, l] } }
    .collect do |path, lang|

  target = File.join(
    'romcal_converted',
    File.basename(path).sub(/.js$/, "-#{lang}.txt")
  )
  jsmodule = path.sub(/^node_modules\//, '')

  file target => [path] do
    sh "nodejs bin/romcal-export.js #{jsmodule} #{lang} > #{target}"
  end

  target
end

desc 'refresh data files exported from the JS library `romcal`'
task :romcal_export => romcal_export_targets

task :default => [:romcal_export]
