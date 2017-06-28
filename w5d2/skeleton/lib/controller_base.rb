require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req, @res = req, res

    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "double render error" if already_built_response?

    @res.status = 302
    @res['Location'] = url

    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "double render error" if already_built_response?

    @res['Content-Type'] = content_type
    @res.write content

    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)

    # controller_name = self.class.to_s.underscore
    controller_name = ActiveSupport::Inflector::underscore(self.class.to_s)

    path = "views/#{controller_name}/#{template_name}.html.erb"

    erb_code = File.read(path)

    thing_to_render = ERB.new(erb_code).result(binding)

    render_content(thing_to_render, "text/html")
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end
