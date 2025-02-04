$LOAD_PATH.unshift 'lib'
require 'resque/version'

Gem::Specification.new do |s|
  s.name              = "resque-mongo"
  s.version           = Resque::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Resque-mongo is resque fork with a mongo backend."
  s.homepage          = "http://github.com/ctrochalakis/resque-mongo"
  s.email             = "yatiohi@ideopolis.gr"
  s.authors           = [ "Christos Trochalakis" ]

  s.files             = %w( README.markdown Rakefile LICENSE HISTORY.md )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.files            += Dir.glob("test/**/*")
  s.files            += Dir.glob("tasks/**/*")
  s.executables       = [ "resque", "resque-web" ]

  s.extra_rdoc_files  = [ "LICENSE", "README.markdown" ]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_dependency "mongo",           ">= 1.3.1"
  s.add_dependency "vegas",           "~> 0.1.2"
  s.add_dependency "sinatra",         ">= 0.9.2"
  s.add_dependency "json",            ">= 1.1.0"

  s.description = <<description
    Resque-mongo is a fork of resque that uses mongo as a queue backend.

    Resque is a Redis-backed Ruby library for creating background jobs,
    placing those jobs on multiple queues, and processing them later.

    Background jobs can be any Ruby class or module that responds to
    perform. Your existing classes can easily be converted to background
    jobs or you can create new classes specifically to do work. Or, you
    can do both.

    Resque is heavily inspired by DelayedJob (which rocks) and is
    comprised of three parts:

    * A Ruby library for creating, querying, and processing jobs
    * A Rake task for starting a worker which processes jobs
    * A Sinatra app for monitoring queues, jobs, and workers.
description

end

