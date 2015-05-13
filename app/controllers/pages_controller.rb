class PagesController < ApplicationController
  def terms
  end

  def about
  end

  def faq
    @faqs = [Commonquestion.new("What is Taskdom?", "Taskdom is an awesome tool that is going to change your life. Taskdom is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. Taskdom may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool.", "what-is-Taskdom"), Commonquestion.new("How do I join Taskdom?", "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!", "how-do-i-join-Taskdom"), Commonquestion.new("When will Taskdom be finished?", "Taskdom is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!", "when-will-Taskdom-be-finished")]
  end

  def sign_up
    @user = User.new
  end

end
