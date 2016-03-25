RSpec.shared_examples 'for successfull request' do |format|
  format ||= 'application/json'
  it "responds with #{format} format" do
    expect(response.content_type).to eq(format)
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

RSpec.shared_examples 'for rendering templates' do |names|
  names.each do |name|
    it "renders the '#{name}' template" do
      expect(response).to render_template(name)
    end
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

RSpec.shared_examples 'for render nothing with status' do |code|
  it "responds with #{code} status" do
    expect(response.status).to eq(code)
  end

  it 'renders nothing' do
    expect(response).to render_template(nil)
  end
end

RSpec.shared_examples 'for saved from' do |title|
  it "saves #{title} project" do
    expect(assigns(:project)).to be_persisted
  end
end

RSpec.shared_examples 'for Project instance' do
  it 'assigns @project to instance of Project' do
    expect(assigns(:project)).to be_a(Project)
  end
end

RSpec.shared_examples 'for assigns @project to nil' do
  it 'assigns @project to nil' do
    expect(assigns(:project)).to be_nil
  end
end
