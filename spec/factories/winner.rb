Factory.define :winner do |winner|
  winner.association       :wholesaler
  winner.winner_name       "John Dough"
end
