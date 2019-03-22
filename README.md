# SplitRailsLogs [![Build Status](https://travis-ci.org/nickbrowne/split_rails_logs.svg?branch=master)](https://travis-ci.org/nickbrowne/split_rails_logs)

Splits rails logs into separate files for each RSpec example, allowing much easier debugging without having to sift through one file containing everything.

Mostly intended for CI environments, where it can be valuable to capture Rails logs for test failures and upload them as build artifacts for later inspection.

## Usage

Add to Gemfile

```rb
gem 'split_rails_logs'
```

Require it:

```rb
require "split_rails_logs"
```

And add to your RSpec configuration:

```rb
RSpec.configure do |config|
  config.around do |example|
    SplitRailsLogs.for_failed(example)
  end
end
```

`for_failed` will only write out logs for examples that have failed. If you want split logs for everything, you can instead use `for_any`:

```rb
SplitRailsLogs.for_any(example)
```

You'll now end up with a separate Rails log per example:
```
log
├── spec
│   └── events
│       └── user
│           ├── locked_spec.rb:12.test.log
│           ├── locked_spec.rb:25.test.log
│           └── unlocked_spec.rb:33.test.log
```

If you're using something like buildkite, [configure it to upload all artifacts that match the appropriate pattern](https://buildkite.com/docs/pipelines/artifacts), for example:

```
- label: "Unit specs"
  command: "bin/ci-unit"
  artifact_paths: ["log/spec/**/*.test.log"]
```

Various other CI platforms will have similar configurations available.

## License

MIT
