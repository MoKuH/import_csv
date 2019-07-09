require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

	describe "DELETE #users" do
		render_views
		it "clean users db" do
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			User.create(name: 'test',date: Date.today,number: 1, description: "test description")
			expect( User.count).to eq(2)

			delete :destroy
			expect(response).to have_http_status(:redirect)
			expect( User.count).to eq(0)
		end

	end


end
