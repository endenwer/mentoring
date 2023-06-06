class PingService
  include RespondService

  def call
    success('pong')
  end
end
