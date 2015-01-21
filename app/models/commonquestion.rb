class Commonquestion
  attr_accessor :question, :answer, :slug

  def initialize(question, answer, slug)
    @question = question
    @answer = answer
    @slug = slug
  end
end
