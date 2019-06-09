describe 'Resources' do

  path '/api/v1/resources' do

    get 'Return all Resources' do
      tags 'Resources'
      produces 'application/json', 'application/xml'
      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            point: { type: :integer },
            name: { type: :string }         
          }
        run_test!
      end
    end
  end
end