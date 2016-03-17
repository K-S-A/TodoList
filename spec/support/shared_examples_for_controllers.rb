RSpec.shared_examples 'for successful json request' do
  it 'responds to json format' do
    expect(response.content_type).to eq 'application/json'
  end

  it 'responds with success status' do
    expect(response).to have_http_status(:success)
  end
end

RSpec.shared_examples 'for assigning instance variable' do |inst_var|
  let(:inst_var_value) { instance_variable_get("@#{inst_var}") }

  it "assigns #{inst_var} of current user to @#{inst_var}" do
    expect(assigns(inst_var)).to eq(inst_var_value)
  end
end

RSpec.shared_examples 'for rendering template' do |name|
  it "renders the '#{name}' template" do
    expect(response).to render_template(name)
    expect(response).to render_template('_project')
  end
end

RSpec.shared_examples 'for responding with json' do |obj, res|
  it "responds with #{obj} of #{res} attributes" do
    expect(json).to eq(result)
  end
end

RSpec.shared_examples 'for not authorized response' do
  it 'responds with 401 status if user is not authorized' do
    log_out
    reset_session

    expect(response.status).to eq(401)
    expect(json['error']).to eq(error)
  end
end
