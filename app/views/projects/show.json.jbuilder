json.(@project, :id, :title, :description)

json.tasks do
  json.(@project.tasks) do |task|
    json.(task, :id, :name, :deadline, :completed)
    
    json.comments do
      json.(task.comments) do |comment|
        json.(comment, :id, :body, :file_link)
      end
    end
  end
end
