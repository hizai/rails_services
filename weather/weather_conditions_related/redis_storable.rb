module RedisStorable

  def redis_store key
    redis.set key.to_s, yield 
  end

  def redis_retrieve key, options = {}
    begin
      format_with options[:as], redis.get( key )
    rescue
      nil
    end
  end

private

  def format_with format_type, source
    case format_type 
      when :hash then JSON.parse source
      else source
    end
  end

module_function

  def redis
    Redis.current
  end

end