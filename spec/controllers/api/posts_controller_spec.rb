require 'spec_helper'
require 'rails_helper'

load "#{Rails.root}/app/controllers/api/posts_controller.rb"

describe Api::PostsController do
  it "should be able to create a new post" do
    post :create, post: { title: 'First post', body: 'First post body' }, format: :json
    response.should be_success
    json_response.should == { 'id' => 1, 'title' => 'First post', 'body' => 'First post body', 'err_msg' => '', 'timestamp' => Time.now.to_i }
  end

  it "should be able to get existsing posts" do
    post :create, post: { title: 'First post', body: 'First post body' }, format: :json
    get :index, format: :json
    expect(response).to be_success
    json_response.should == [{ 'id' => 1, 'title' => 'First post', 'body' => 'First post body', 'err_msg' => '', 'timestamp' => Time.now.to_i }]
  end

  it "should be able to update an existing post" do
    post :create, post: { title: 'First post', body: 'First post body' }, format: :json
    put :update, id: 1, post: { title: 'First post upd', body: 'First post body upd' }, format: :json
    response.should be_success
    json_response.should == { 'id' => 1, 'title' => 'First post upd', 'body' => 'First post body upd', 'err_msg' => '', 'timestamp' => Time.now.to_i }
  end

  it "should be able to delete an existing post" do
    post :create, post: { title: 'First post', body: 'First post body' }, format: :json
    delete :destroy, id: 1, post: { title: 'First post', body: 'First post body' }, format: :json
    response.should be_success
    json_response.should == { 'id' => 1, 'title' => 'First post', 'body' => 'First post body', 'err_msg' => '', 'timestamp' => Time.now.to_i }
    expect(Post.count).to eq(0)
  end
end
