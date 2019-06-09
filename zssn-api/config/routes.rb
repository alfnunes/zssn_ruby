Rails.application.routes.draw do 

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope 'api/v1' do
   
    resources :resources do     
    end

    resources :survivors do
      collection do       
        get ':id/report_infection' => 'survivors#report_infection'      
      end
    end

    post :trades, to: 'trades#trade'

    resources :reports do
      collection do   
        get :percentage_infected, to: 'reports#percentage_infected'
        get :percentage_non_infected, to: 'reports#percentage_non_infected'
        get :avg_resource_by_survivor, to: 'reports#avg_resource_by_survivor' 
        get :points_lost, to: 'reports#points_lost' 
      end
    end  
  end
end