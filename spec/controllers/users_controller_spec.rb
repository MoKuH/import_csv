require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "GET #new" do
		render_views
		it "returns http success" do
			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #index" do
		render_views
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end

		it "returns csv file" do
			get :index, :format => :csv
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET #show" do
		render_views
		it "returns http success" do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			get :show, params: {id: User.last.id}
			expect(response).to have_http_status(:success)
		end
	end

	describe "PUT user" do
		render_views
		it 'should update the user' do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id, user:{id: User.last.id,name: "test rspec"}}
			expect(response).to have_http_status(:redirect)
			expect( User.last.name).to eq("test rspec")
		end

		it 'should not update the user if wrong permit' do
			u = User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			expect {
				put :update,params: {id: User.last.id ,name: "test rspec"}
			}.to raise_error(ActionController::ParameterMissing)
		end

		it 'should not update the user' do
			u = User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id, user:{id: User.last.id,name: ""}}
			expect(response).to have_http_status(:success)
			expect( User.last.name).to eq("test")
		end

	end

	describe "PUT user" do
		render_views
		it 'should update the user' do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id, user: {id: User.last.id,name: 'test2',date: Date.today,number: 2, description: "test description 2"}}
			expect(response).to have_http_status(:redirect)

			expect( User.last.name).to eq("test2")
			expect( User.last.number).to eq(2)
			expect( User.last.description).to eq("test description 2")
		end
	end

	describe "DELETE #user " do
		render_views
		it "delete user" do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			expect( User.count).to eq(2)
			delete :destroy, params:{id: User.last.id}
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(1)
		end
	end
	describe "Post users" do
		render_views
		it 'should not create users if I dont attach a file' do
			expect {
				post :create
			}.to raise_error(ActionController::ParameterMissing)
			expect( User.count).to eq(0)
		end

		it 'should  create 20 users ' do

			file = fixture_file_upload('files/coding-test-file.csv')
			post :create, params:{user: {:file => file}}
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(20)
		end
		it 'should  create 19 users ' do
			file = fixture_file_upload('files/coding-test-file-1-error.csv')
			post :create, params:{user: {:file => file}}

			expect(response).to have_http_status(:redirect)

			expect( User.count).to eq(19)
		end
		it 'should not create user and not crash if file is not a users file' do
			file = fixture_file_upload('files/coding-test-file-1-error.csv')
			post :create, params:{user: {:file => file}}
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(19)
		end

		it 'should not create user and not crash if file not a csv' do
			file = fixture_file_upload('files/blank.pdf')
			post :create, params:{user: {:file => file}}
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(0)
		end

		it 'should not create user and not crash if file is a bad encoded csv' do
			file = fixture_file_upload('files/pdf_renamed_to.csv')
			post :create, params:{user: {:file => file}}
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(0)
		end

	end

end
