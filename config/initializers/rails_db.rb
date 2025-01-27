if defined?(RailsDb)
    RailsDb.setup do |config|
      config.verify_access_proc = proc { |_controller| Rails.env.development? }
    end
else
    Rails.logger.warn('RailsDb is not loaded.')
end