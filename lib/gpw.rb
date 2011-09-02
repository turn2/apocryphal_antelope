class Gpw
  def password
    base = `pwgen -1`.chomp
    base += rand(99).to_s.ljust(2, "0")
  end
end
