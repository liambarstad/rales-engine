class Api::V1::WelcomeController < ApplicationController
  
  def index
    readme = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    html = readme.render(File.read("#{Rails.root}/README.md"))
    render html: html.html_safe
  end

end
