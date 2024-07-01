# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base

  default from: 'picks.games job board <no-reply@tldr.mx>'
  layout 'mailer'

end
