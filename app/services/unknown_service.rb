class UnknownService
  include RespondService

  def call
    success('Unknown command')
  end
end
