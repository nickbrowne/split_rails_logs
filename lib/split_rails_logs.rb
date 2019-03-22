require "active_support"
require "fileutils"
require "logger"
require "stringio"

class SplitRailsLogs
  # Write out logs for each example
  def self.for_all(example)
    capture_logs_for(example) do |path, string|
      write_logs(path, string)
    end
  end

  # Write out logs only for each failed example
  def self.for_failed(example)
    capture_logs_for(example) do |path, string, failed|
      write_logs(path, string) if failed
    end
  end

  private_class_method def self.capture_logs_for(example)
    raise "SplitRailsLogs - Must initialize Rails application first" unless defined?(Rails) && Rails.initialized?

    # reusing the io and logger instances each time prevents
    # runaway memory usage
    @io ||= StringIO.new
    @logger ||= Logger.new(@io).tap do |logger|
      Rails.logger.extend(ActiveSupport::Logger.broadcast(logger))
    end

    # beause we're reusing the same io and logger
    # we need to truncate and rewind the io each time
    @io.truncate(0)
    @io.rewind

    example.call

    log_file_suffix = "_line_#{example.metadata[:line_number]}.test.log"
    log_path = Rails.root.join("log").join(example.metadata[:file_path].sub(".rb", log_file_suffix))

    yield log_path, @io.string, example.exception
  end

  private_class_method def self.write_logs(path, string)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, string)
  end
end
