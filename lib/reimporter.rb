require 'kmts'

module KMExport
  class Reimporter
    def send_to_KM json, key
      KMTS.init(key,
        :use_cron => false, 
        :to_stderr => true)
    end
  end
end
