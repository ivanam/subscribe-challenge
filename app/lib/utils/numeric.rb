class Numeric
  def ceil_to_nearest(step)
    (self / step.to_f).ceil * step
  end

  def round_off
    sprintf("%.2f", self)
  end
end