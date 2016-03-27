require 'rails_helper'

RSpec.describe TasksController, type: :routing do
  context 'routing' do
    it 'routes to #index' do
      expect(get: '/tasks').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/tasks/new').not_to be_routable
    end

    it 'routes to #show' do
      expect(get: '/tasks/1').not_to be_routable
    end

    it 'routes to #edit' do
      expect(get: '/tasks/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'projects/1/tasks').to route_to('tasks#create', project_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/tasks/1').to route_to('tasks#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/tasks/1').to route_to('tasks#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/tasks/1').to route_to('tasks#destroy', id: '1')
    end
  end
end
