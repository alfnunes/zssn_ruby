describe 'Reports' do

  path '/api/v1/reports/percentage_infected' do

    get 'Return Percentage of infected survivors' do
      tags 'Reports'
      produces 'application/json', 'application/xml'
      response '200', 'report found' do
        schema type: :object,
          properties: {
            description: { type: :string },
            percentage: { type: :integer }                  
          }
        run_test!
      end
    end
  end
 
  path '/api/v1/reports/percentage_non_infected' do

    get 'Return Percentage of non infected survivors' do
      tags 'Reports'
      produces 'application/json', 'application/xml'
      response '200', 'report found' do
        schema type: :object,
          properties: {
            description: { type: :string },
            percentage: { type: :integer }                  
          }
        run_test!
      end
    end
  end

  path '/api/v1/reports/avg_resource_by_survivor' do

    get 'Return Average amount of each kind of resource by survivor' do
      tags 'Reports'
      produces 'application/json', 'application/xml'
      response '200', 'report found' do
        schema type: :object,
          properties: {
            description: { type: :string },
            avg_ammunition: { type: :float },
            avg_medication: { type: :float },
            avg_food: { type: :float },
            avg_water: { type: :float }  
          }
        run_test!
      end
    end
  end

  path '/api/v1/reports/points_lost' do

    get 'Return Points lost because of infected survivor' do
      tags 'Reports'
      produces 'application/json', 'application/xml'
      response '200', 'report found' do
        schema type: :object,
          properties: {
            description: { type: :string },
            number: { type: :integer }                  
          }
        run_test!
      end
    end
  end
end