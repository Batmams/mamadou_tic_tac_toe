require "pry"

class Game
  #ON INITIALISE LES VARIABLES DE CLASSE
  attr_accessor :board, :player_1, :player_2, :timer

  def initialize(player_1 = Player.new("X", names = gets.chomp), player_2 = Player.new("O", names = gets.chomp), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  #ON INITIALISE LE TABLEAU WIN_COMBINATIONS CONTENANT DES TABLEAUX DE COMBINAISONS GAGNANTES
  def winning_combinations
    winning_combinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
    ]
  #ON RAPPELLE QUE 0 DANS CET ARRAY EQUIVAUT A LA CASE 1 DU JEU, ET AINSI DE SUITE JUSQU'A 8 QUI EQUIVAUT A LA CASE 9
  end

  #BOARD.TURN_COUNT COMPTE LE NOMBRE DE TOURS JOUES
  #AINSI, AVEC K=BOARD.TURN_COUNT, BOARD.TURN_COUNT.EVEN? RENVOIE LA VALEUR TRUE AUX TOURS K%2=0 ET FALSE AUX TOURS K%2=1
  #.EVEN? A POUR PARAMETRES "? TRUE : FALSE", ET AVEC " ? PLAYER_1 : PLAYER_2" ON REMPLACE PLAYER_1 PAR TRUE ET PLAYER_2 PAR FALSE
  #DONC BOARD.TURN_COUNT.EVEN? RENVERRA PLAYER_1 AU LIEU DE TRUE ET FALSE AU LIEU DE PLAYER_2 
  def player_turn
    board.turn_count.even?  ? player_1 : player_2
  end
 
  def won?
    winning_combinations.find do |combi|
      #([a, b, c] étant une combinaison pour gagner une partie)
      # le "pion" étant X ou O
      # POUR CHAQUE "combi = [a, b, c]" la boucle va vérifier si le pion à a est le même que celui à b :
      # d'où : board.cells[combi[0]] == board.cells[combi[1]]
      # Si cette condition est vérifiée pour une combi, la boucle va vérifier maintenant si le pion à b est le même que celui à c
      # d'où board.cells[combi[1]] == board.cells[combi[2]]
      # Si cette condition est aussi vérifiée pour cette même combi, la boucle va enfin vérifier si a est bel et bien égal à un pion et non à une case vide " "
      # Si toutes ces conditions sont vérifiées pour une combinaison, alors find a trouvé la combi gagnante et won?[] est égale au array de la combinaison gagnante
      board.cells[combi[0]] == board.cells[combi[1]] && board.cells[combi[1]] == board.cells[combi[2]] && board.cells[combi[0]] != " "
    end
  end

  #RETOURNE LA VALEUR TRUE SI UN DES DEUX JOUEURS A GAGNE OU SI LE TABLEAU EST PLEIN
  def over?
    won? || board.full?
  end
  
  def winner
    #WINNER EST LE NOM DU JOUEUR 1 SI LA VALEUR A LA PREMIERE CASE DE WON? EST EGALE A X (WON? ETANT LE ARRAY DE LA COMBINAISON GAGNANTE DE LA PARTIE ACTUELLE)
    if won?
      if board.cells[won?[0]] == "X"
        player_1.names
    #WINNER EST LE NOM DU JOUEUR 2 SI LA VALEUR A LA PREMIERE CASE DE WON? EST EGALE A O
      elsif board.cells[won?[0]] == "O"
        player_2.names
      end
    end
  end

  def turn
    #AFFICHE A QUEL JOUEUR CEST LE TOUR
    puts "C'est à #{player_turn.names} de jouer"
    #INPUT PREND COMME VALEUR LE NOMBRE ENTRE PAR LE JOUEUR A QUI C'EST LE TOUR
    puts "Entrez le numero de votre case :"
    input = gets.chomp.to_i

    #SI LA VALEUR ENTRE DANS LE BOARD CORRESPOND A UNE CASE DISPONIBLE ET COMPRISE ENTRE 1 ET 9, LA CASE PRENDRE COMME VALEUR LE SIGNE "TOKEN" DU JOUEUR ET ON AFFICHE LE NOUVEAU BOARD
    if board.valid_move?(input.to_s)
      #LA CASE INPUT DU TABLEAU BOARD PREND COMME VALEUR LE SIGNE (TOKEN) DE PLAYER_TURN
      board.newposition(input, player_turn)
      #NETTOIE LE TERMINAL
      system"clear"
      #AFFICHAGE DU TABLEAU BOARD
      board.display

    #SINON, SI L'INPUT ENTRE PAR LE JOUEUR N EST PAS COMPRIS ENTRE 1 ET 9, AFFICHER.
    elsif input.between?(1, 9) == false
      puts "Entrer un nombre entre 1 et 9"

    #SINON, AFFICHER..
    else
      puts "Cette case est déjà prise"
    end
  end
  def play
    #INITIALISER LE TABLEAU DU JEU
    board.reset
    #NETTOIE LE TERMINAL
    system"clear"
    #AFFICHER LE TABLEAU DU JEU
    board.display
    #JUSQU A CE QUE LE TABLEAU SOIT PLEIN OU QU UN JOUEUR AIT GAGNE, EFFECTUER TURN
    until over?
      turn
    end
    #SI LE TABLEAU EST PLEIN, AFFICHER..
    if board.full?
      puts "Il n'y a pas de gagnant"
    #SI UN JOUEUR A REMPLI UNE DES 8 COMBINAISONS, AFFICHER..
    elsif won?
      puts "Le gagnant est #{winner}"
    end
  end
end
