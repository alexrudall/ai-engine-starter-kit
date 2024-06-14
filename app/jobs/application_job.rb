class ApplicationJob < ActiveJob::Base
  # If it fails, it fails
  sidekiq_options retry: 0

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
