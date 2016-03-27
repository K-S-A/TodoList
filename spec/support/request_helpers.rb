module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def to_json(project)
      project.attributes.reject { |k, _| k =~ /_/ }.merge('tasks' => [])
    end

    def extract_json(attrs, params)
      attrs = attrs.dup.extract!(*params).stringify_keys!
      attrs['deadline'] = attrs['deadline'].to_s if attrs['deadline']

      attrs
    end
  end
end