class Card
  attr_reader :face_value, :face_status

  def initialize(face_value)
    @face_value = face_value
    @face_status = nil
  end

  def hide
    @face_status = nil
  end

  def reveal
    @face_status = @face_value
  end

  def to_s
    @face_value.to_s
  end

  def ==(other_card)
    @face_value == other_card.face_value
  end
end
