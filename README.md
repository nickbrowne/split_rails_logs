# SplitRailsLogs

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
RSpec.configure do |config|
  config.around do |example|
    SplitRailsLogs.for_any(example)
  end
end
```

## License

MIT
