class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = 'localhost:3000'
  default from: "Danny@odinbook.com"
  layout "mailer"
end
