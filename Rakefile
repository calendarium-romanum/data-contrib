require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

romcal_export_targets =
  Dir['node_modules/romcal/dist/calendars/*.js']
    .reject {|s| s.end_with? 'index.js' }
    .collect do |path|

  target = File.join(
    'romcal_converted',
    File.basename(path).sub(/.js$/, '.txt')
  )
  jsmodule = path.sub(/^node_modules\//, '')

  # no prerequisites defined => always refresh
  file target do
    sh "nodejs bin/romcal-export.js #{jsmodule} > #{target}"
  end

  target
end

desc 'refresh data files exported from the JS library `romcal`'
task :romcal_export => romcal_export_targets

task :default => [:romcal_export]
