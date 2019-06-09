describe 'Trade' do

  path '/api/v1/trades' do

    post 'Make a trade' do
      tags 'Trades'
      produces 'application/json', 'application/xml'      
      parameter name: :trade, in: :body, schema: {
        type: :object,
        properties: {
          trade: {
            properties: { 
              survivor_1: { 
                properties: { 
                  id: { type: :integer },
                  resources: { type: :array,  
                              items: { 
                                properties: { 
                                  resource_id: {type: 'integer'},
                                  name: {type: 'string'}, 
                                  amount: {type: 'integer'}  
                                } 
                              }
                  }
                }  
              },
              survivor_2: { 
                properties: { 
                  id: { type: :integer },
                  resources: { type: :array,  
                              items: { 
                                properties: { 
                                  resource_id: {type: 'integer'},
                                  name: {type: 'string'}, 
                                  amount: {type: 'integer'}  
                                } 
                              }
                  }
                }  
              }
            } 
          }        
        }      
      }

      response '200', 'trade finished' do
        let(:trade) { 'ok' }
        run_test!
      end
      
      response '404', 'Survivor doesnt exist' do
        let(:survivor) { 'invalid' }
        run_test!
      end

      response '400', 'There is a Survivor infected or maybe the points of resource is not equal' do
        let(:survivor) { 'invalid' }
        run_test!
      end
      
      response '500', 'Resource not found"' do
        let(:survivor) { 'invalid' }
        run_test!
      end
    end
  end
end