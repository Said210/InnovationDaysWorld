json.extract! project, :id, :title, :description, :participant_limit, :is_winner, :tech_stack, :is_open, :created_at, :updated_at
json.url project_url(project, format: :json)
