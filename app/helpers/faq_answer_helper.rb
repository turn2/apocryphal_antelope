module FaqAnswerHelper
  def format_answer(text)
    text.gsub(/(http(s)?:\/\/\S*)/, "<a href='\\1' class='external'>\\1</a>").gsub(/\n/,"<br/>")
  end

  def faq_class(faq)
    (faq.visible? and "visible") || "hidden"
  end
end
