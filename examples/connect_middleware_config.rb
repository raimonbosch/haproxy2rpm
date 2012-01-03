class NodeJsLineParser

  def initialize(line)
     @parts = @line.split("\s")
  end

  def response_time
    @response_time ||= @parts[3].to_i
  end


  def status_code
    @status_code ||= @parts[2].to_i
  end

  def http_method
    @http_method ||= @parts[0]
  end

  def uri
    @uri ||= URI.parse(@parts[1])
  end

  def http_path
    uri.path
  end

  def http_query
    uri.query
  end

  def is_error?
    status_code >= 500
  end

end

config.message_parser = lambda do |line|
  NodeJsLineParser.new(line)
end

config.request_recorder = lambda do |request|
  rpm_number_unit = 1000.0
  params = {
    'metric' => "Controller#{route_for(request.http_path)}"
  }

  if request.is_error?
    params['is_error'] = true
    params['error_message'] = "#{request.uri} : Status code #{request.status_code}"
  end

  record_transaction(request.response_time / rpm_number_unit, params)
  Haproxy2Rpm.logger.debug "RECORDING (transaction) #{request.http_path}: #{params.inspect}"
end

config.routes = [
  {
    :pattern => %r{^/$},
    :target => '/index'
  },
  {
    :pattern => %r{(\.[a-zA-Z_]{2,4})$},
    :target => '/static'
  }
]

