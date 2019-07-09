require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "GET #index" do
		render_views
		it "returns http success" do
			get :index
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

	describe "PATCH user" do
		it 'should update the user' do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id, user:{id: User.last.id,name: "test rspec"}}
			expect(response).to have_http_status(:redirect)
			expect( User.last.name).to eq("test rspec")
		end

		it 'should not update the user' do
			u = User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id ,name: "test rspec"}
			expect(response).to have_http_status(:redirect)
			expect( u.name).to eq(User.last.name)
		end

	end

	describe "PUT user" do
		it 'should update the user' do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			put :update,params: {id: User.last.id, user: {id: User.last.id,name: 'test2',date: Date.today,number: 2, description: "test description 2"}}
			expect(response).to have_http_status(:redirect)

			expect( User.last.name).to eq("test2")
			expect( User.last.number).to eq(2)
			expect( User.last.description).to eq("test description 2")
		end
	end

end
