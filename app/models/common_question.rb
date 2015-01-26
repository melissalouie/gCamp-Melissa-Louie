class CommonQuestion
  attr_accessor :question, :answer, :slug

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def generate_slug
    @question.downcase.gsub('?',' ').gsub(' ', '-')
  end
end
