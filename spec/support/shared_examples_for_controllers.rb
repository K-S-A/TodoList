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
  end
end
