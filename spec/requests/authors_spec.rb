require 'swagger_helper'

RSpec.describe 'authors', type: :request do

  path '/authors/{id}' do
    parameter name: 'id', in: :path, required: true, schema: { type: :integer }

    get('show the current author') do
      response '200', 'Successful' do
        examples 'application/json' => {
          author:{
          id: 1,
          name: 'John Doe',
          email: 'johndoe@home.com'
          }
          # Add more example data as per your user model
        }
        run_test!
      end
    end
  end

  path '/articles' do
    get("show all articles present") do
      response "200", "Successful" do
        examples "application/json" => [
          {
            id: 1,
            title: "Top Movies of all time",
            body: "Go and search yourself :)",
            author: "Kaiser Sakhi",
            created_at: "12-12-2020"
          }
        ]
        run_test!
      end
    end
  end

  path '/register' do
    post "register a author" do
      consumes "application/json"
      produces "application/json"
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string, example: "John Doe"},
          email: {type: :string, example: "johndoe@example.com"},
          password: {type: :string, example: "password"}
        },
        required: [:email, :password, :name]
      }

      response "201", "Author registered successfully" do
        let(:author) {{email: "johndoe@example.com", password: "password", name: "John Doe"}}
        run_test!
      end
    end
  end

  path '/login' do
    post "login an author and return auth token" do
      consumes "application/json"
      produces "application/json"

      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          email: {type: :string, example: "johndoe@example.com"},
          password: {type: :string, example: "password"}
        },
        required: [:email, :password]
      }

      response "200", "Logged in successfully" do
        let(:token) {{token: "xxx"}}
        run_test!
      end
    end
  end

  path "/logout" do
    delete "logouts a author and invalidates the token" do
      consumes "application/json"
      produces "application/json"

      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          token: {type: :string, example: "paste-token-here"}
        },
        required: [:token]
      }

      response "200", "Logged out successfully" do
        let(:status) {{status: "xxx"}}
        run_test!
      end
    end
  end
end

