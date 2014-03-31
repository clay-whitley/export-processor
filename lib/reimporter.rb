class JSONQueue < Queue
  def initialize(opts)
    super()
    @io = IO.open(IO.sysopen(opts[:file]))
    @counter = opts[:counter]
  end

  def add_to_queue
    100.times do
      self << JSON.parse(@io.readline)
    end
    @counter += 100
    puts "Adding 100 lines to queue, #{counter} so far"
  end
end

module KMExport
  class Reimporter
    def send_to_KM(json, key)
      pool = 10
      threads = []
      queue = JSONQueue.new({file: json, counter: 0})

      queue.add_to_queue

      pool.times do
        threads << Thread.new do
          KMTS.init(key,
          :use_cron => false, 
          :to_stderr => true)
          until queue.empty?
            queue.add_to_queue if queue.length < 50
            work_unit = queue.pop(true) rescue nil
            send_line_to_KM(work_unit)
          end
        end
      end

      threads.each { |t| t.join }

      STDOUT.print('Reimportation process completed.')
    end

    def send_line_to_KM(line)
      identity = line.delete("_p")
      second_identity = line.delete("_p2")
      event = line.delete("_n")
      line["_d"] = 1

      KMTS.alias(identity,second_identity) if second_identity
      KMTS.record(identity,event,line) if event
      KMTS.set(identity,line) unless event || second_identity
    end
  end
end
