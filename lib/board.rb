#CLASSE DU TABLEAU
class Board
  attr_accessor :cells

  #INITIALISE L ARRAY CELLS DANS LA METHODE RESET
  def initialize
    reset
  end

  #INITIALISE LE ARRAY DU JEU A DES ELEMENTS EGAUX A DES STRING VIDES
  def reset
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  #AFFICHE LE TABLEAU DU JEU DONT LA CASE INPUT - 1 PREND LA VALEUR X, O, ou " "
  def display
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  #RETOURNE FALSE SI LE TABLEAU CELLS A ENCORE DES CASES EGALES A " "
  def full?
    cells.none? {|cell| cell == " "}
  end

  #IL COMPTE LE NOMBRE DE X OU BIEN LE NOMBRE DE O QU IL Y A DANS L ARRAY CELLS
  def turn_count
    cells.count {|cell| cell == "X" || cell == "O"}
  end

  #RETOURNE TRUE SI LA VALEUR ENTRE EST DEJA PRISE A LA CASE INPUT - 1 DU JEU (L'ARRAY CELLS COMMENCE A 0 ET LE TABLEAU DU JEU COMMENCE A 1)
  def take?(input)
    cells[input - 1] == "X" || cells[input - 1] == "O"
  end

  #RETOURNE TRUE SI L'INPUT ENTRE CORRESPOND A UNE CASE INPUT - 1 DEJA PRISE DANS LE JEU ET SI ELLE EST COMPRISE ENTRE 1 ET 9
  def valid_move?(input)
    input = input.to_i
    !(take?(input)) && input.between?(1, 9)
  end

  #LA CASE INPUT - 1 DU TABLEAU CELLS PREND COMME VALEUR LE SIGNE (TOKEN) DE PLAYER
  def newposition(input, player)
    input = input.to_i
    cells[input -1] = player.token
  end
end