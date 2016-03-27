RSpec.shared_context 'logged in user' do
  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, user: @user)
  end  

  let!(:log_in) { sign_in @user }

  let(:error) { 'You need to sign in or sign up before continuing.' }
  let(:log_out) { sign_out @user }
end

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

RSpec.shared_examples 'for saved from' do |title, attribute|
  it "saves #{title} #{attribute}" do
    expect(assigns(attribute)).to be_persisted
  end
end

RSpec.shared_examples 'for new instance' do |name|
  it "assigns @#{name} to instance of #{name.classify}" do
    expect(assigns(name)).to be_a(name.classify.constantize)
  end
end

RSpec.shared_examples 'for assigning instance variable to nil' do |name|
  it "assigns @#{name} to nil" do
    expect(assigns(name)).to be_nil
  end
end

RSpec.shared_examples 'for instance params' do |params, name|
  it "assigns new #{name} as @#{name}" do
    var = instance_variable_get("@#{name}")
    params.each do |param|
      expect(assigns(name)[param]).to eq(var[param])
    end
  end
end

RSpec.shared_examples 'for json-object with attributes of' do |params, name|
  it "responds with json-object of @#{name} attributes" do
    attrs = extract_json(instance_variable_get("@#{name}").attributes, params)

    expect(json.except('id')).to eq(attrs)
  end
end

RSpec.shared_examples 'for failed update of' do |obj|
  it "fails to update #{obj}" do
    expect(assigns(obj)).to eq(instance_variable_get("@#{obj}"))
  end
end

RSpec.shared_examples 'for removing of' do |obj|
  it "removes #{obj} from database" do
    klass = obj.classify.constantize
    create_other

    expect { reset_session }.to change { klass.count }.by(-1)

    expect do
      klass.find(create_other.id)
    end.to raise_error(ActiveRecord::RecordNotFound)
  end
end

