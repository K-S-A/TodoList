module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def to_json(project)
      project.attributes.reject { |k, _| k =~ /_/ }.merge('tasks' => [])
    end
  end
end