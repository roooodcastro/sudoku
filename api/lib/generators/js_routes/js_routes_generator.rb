# frozen_string_literal: true

class JsRoutesGenerator < Rails::Generators::Base
  def create_initializer_file
    default_url_options = Rails.application.config.action_mailer.default_url_options

    create_file(
      Rails.root.join('../web/src/api_routes.js'),
      JsRoutes.generate(exclude: /rails/, url_links: true, default_url_options: default_url_options)
    )
  end
end
