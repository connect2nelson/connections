require 'rails_helper'

describe 'routes' do

  it 'should route GET /offices/:name to offices#show' do
    expect(get: 'offices/chicago').to route_to('offices#show', name: 'chicago')
  end

  it 'should route GET /connections/:first_employee_id/and/:second_employee_id to connections#show' do
    expect(get: 'connections/1/and/2').to route_to('connections#show', first_employee_id: '1', second_employee_id: '2')
  end

end
