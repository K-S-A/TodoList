require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  context 'routing' do
    it 'routes to #index' do
      expect(get: '/comments').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/comments/new').not_to be_routable
    end

    it 'routes to #show' do
      expect(get: '/comments/1').not_to be_routable
    end

    it 'routes to #edit' do
      expect(get: '/comments/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: '/tasks/1/comments').to route_to('comments#create', task_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/comments/1').to route_to('comments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/comments/1').to route_to('comments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/comments/1').to route_to('comments#destroy', id: '1')
    end
  end
end
