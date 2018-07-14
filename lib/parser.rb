# frozen_string_literal: true

class Parser
  def parse_user(response)
    contents = parse(response.body, symbolize_names: true)
    message  = success?(response) ? success(contents) : failure(response)
    result(contents, message)
  end

  private

  def parse(source, params)
    JSON.parse(source, params)
  end

  def success?(response)
    response.code == '200'
  end

  def success(contents)
    Messages.success(contents[:screen_name])
  end

  def failure(response)
    Messages.failure(response.code)
  end

  def result(contents, message)
    {
      contents: contents,
      message: message
    }
  end
end
