class Reply < ActionMailer::Base
  def reply_support(sender, receiver)
    @sender=sender
    @receiver=receiver
    subject="Dnia #{Time.now.utc} odpowiedziano na ogloszenie w serwisie Sprzedaj Stara"
    mail(:to=>receiver.to_s,
         :from=>sender.email,
         :subject=> subject)
  end
  def welcome(receiver)
    @sender = 'umtreee@gmail.com',
    mail(:to => receiver,
         :bcc => ["jampolak@poczta.onet.pl", "aaa"])
  end

end

