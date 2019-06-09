describe 'Survivors' do

  path '/api/v1/survivors' do

    get 'Return all Survivors' do
      tags 'Survivors'
      produces 'application/json', 'application/xml'
      response '200', 'survivors found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            age: { type: :integer },
            gender: { type: :string },
            last_location: { properties: { x: { type: :float } , y: { type: :float }} },
            infected: { type: :boolean },   
            reported_infected_count: { type: :integer },      
            created_at: { type: :string},  
            updated_at: { type: :string }      
          }        
        run_test!
      end
    end
  end

  path '/api/v1/survivors/{id}' do

    get 'Return Survivors By Id' do
      tags 'Survivors'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      response '200', 'survivor found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            age: { type: :integer },
            gender: { type: :string },
            last_location: { properties: { x: { type: :float } , y: { type: :float }} },
            infected: { type: :boolean },   
            reported_infected_count: { type: :integer },      
            created_at: { type: :string},  
            updated_at: { type: :string },
            resources: { type: :array,  
              items: { 
                properties: { 
                  resource_id: {type: 'integer'},                
                  amount: {type: 'integer'}  
                } 
              }
            }     
          }        
        run_test!
      end

      response '404', 'survivor not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/survivors/{id}/report_infection' do

    get 'Report infection about the survive' do
      tags 'Survivors'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      response '200', 'survivor found' do
        schema type: :object,
          properties: {
            message: { type: :string }
          }        
        run_test!
      end

      response '404', 'survivor not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/survivors/{id}' do

    put 'Update localization' do
      tags 'Survivors'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :position, in: :body, schema: {
        type: :object,
        properties: {
          latitude: { type: :string },
          longitude: { type: :string }
        },
        required: [ 'latitude', 'longitude' ]
      }

      response '204', 'survivor found' do
        let(:position) { 'ok' }
        run_test!
      end

      response '404', 'survivor not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/survivors' do

    post 'Create Survivor' do
      tags 'Survivors'
      produces 'application/json', 'application/xml'      
      parameter name: :survivor, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          age: { type: :integer },
          gender: { type: :string },
          latitude: { type: :string },
          longitude: { type: :string },
          resources: { type: :array,  
            items: { 
              properties: { 
                resource_id: {type: 'integer'},               
                amount: {type: 'integer'}  
              } 
            }
          }
        },
        required: [ 'name', 'age', 'gender' , 'latitude', 'longitude' ]
      }

      response '201', 'survivor created' do
        let(:survivor) {'ok'}
        run_test!
      end

      response '404', 'survivor not found' do
        let(:survivor) { 'invalid' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:survivor) { 'invalid' }
        run_test!
      end

      response '500', 'error' do
        let(:survivor) { 'internal server error' }
        run_test!
      end
    end
  end
end