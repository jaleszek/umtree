class Confirmation < ActionMailer::Base
  def send_confirmation(receiver)
    @receiver=receiver
    subject="Dnia #{Time.now.utc} zarejestrowales konto w serwisie Sprzedaj stara"
    mail(:to=>receiver.email.to_s,
         :from=>'andrukanisleszek@gmail.com',
         :subject=>subject)
  end
end
