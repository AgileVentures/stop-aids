class Candidate < ActiveRecord::Base
  belongs_to :constitency
  belongs_to :party
  has_many :asks

  def answer_question(question, choice)
    question.create_answer(self, choice)
  end

  def has_answered?(question)
    question.answers.where(:candidate_id => self.id) ? true : false
  end

  def questions_asked_more_times_than(threshold)
    Question.all.select {|question| question.asked_count(self) > threshold}
  end

  def twitter_image_url
    $twitter.user(self.twitter).profile_image_url_https.to_s
  end

  def get_answer_page
    base_link = 'https://stop-aidz-unity2.herokuapp.com'
    page_link = '/candidatesanswers/candidatesanswers'
    param_link = "?candidate_id=#{self.id.to_s}"
    return $bitly.shorten( base_link + page_link + param_link ).short_url
  end

  def tweet_at_candidate
    twitter_address = self.twitter
    twitter_address = '@ctrembath'
    if self.twitter.nil?
      raise_error 'Please get twitter address for ' + self.name
    else
      $twitter.update(twitter_address + ' You have questions waiting for you at ' + get_answer_page )
    end
  end

end
