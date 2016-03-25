json.(project, :id, :title, :description)
json.tasks do
  json.array! project.tasks, partial: 'tasks/task', as: :task
end
