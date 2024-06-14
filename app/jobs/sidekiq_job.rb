# ActiveJob adds quite a lot of overhead and may be 2-20x slower than just using Sidekiq, hence we just use Sidekiq.
class SidekiqJob
  include Sidekiq::Job

  # If it fails, it fails
  sidekiq_options retry: 0
end
