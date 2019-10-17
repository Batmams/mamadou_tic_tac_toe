#FICHIER A EXECUTER POUR JOUER
require 'bundler'
Bundler.require

require_relative 'player'
require_relative 'game'
require_relative 'board'

#CLASSE DE LA BOUCLE DU JEU
class Application
  def start
    puts "Entrer le prenom du joueur 1 puis, entrer le prenom du joueur 2"
    Game.new.play
    puts "Partie terminée!"
  end
end

Application.new.start