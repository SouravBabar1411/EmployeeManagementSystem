class UsersController < ApplicationController

  def index
    
  end

  def fetch_employees
    users = User.all
    search_string = []
    filter_query = ''
    ## Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
    terms = params[:search][:value].split(' ')

    search_columns.each do |column|
      terms.each do |term|
      search_string << "#{column} LIKE '%#{term}%'"
      end
    end
    users = users.where(search_string.join(' OR '))
    end

    if params["filters"].present?
    filters = JSON.parse(params["filters"].gsub("=>", ":").gsub(":nil,", ":null,"))
    users = users.side_bar_filter(filters)
    end
    users = users.order("#{sort_column} #{datatable_sort_direction}") unless sort_column.nil?
    users = users.page(datatable_page).per(datatable_per_page)
    
    render json: {
    users: users.as_json,
      draw: params['draw'].to_i,
      recordsTotal: users.count,
      recordsFiltered: users.total_count,
    }
  end

  def new
  end

  def edit
  end

  def destroy
  end

  ## Returns Datatable Sorting Direction
  def datatable_sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end

  def sort_column
    columns = [%w[first_name], ['email'], ['created_at']]
    columns[params[:order]['0'][:column].to_i - 1].join(', ')
  end

  ## Returns Datatable Page Number
  def datatable_page
    params[:start].to_i / datatable_per_page + 1
  end

  ## Returns Datatable Per Page Length Count
  def datatable_per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  # Search with mentioned column names
  def search_columns
    %w(first_name last_name email)
  end

end
