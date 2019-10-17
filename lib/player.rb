class Player
  attr_reader :token, :names

  #ON INITIALISE LA VARIABLE TOKEN QUI EST LE JETON "X" OU "Y"
  def initialize(token, names)
    @token = token
    @names = names
  end
end
