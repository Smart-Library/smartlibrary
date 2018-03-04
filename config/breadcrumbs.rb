# crumb :root do
#   link "Home", root_path
# end

crumb :groupings do
  link "Groupings", groupings_path
end

crumb :grouping do |grouping|
  link grouping.name, grouping
  if grouping.parent_grouping
    parent :grouping, grouping.parent_grouping
  else
    parent :groupings
  end
end

crumb :desk do |desk|
  link desk.name, desk
  if desk.grouping
    parent :grouping, desk.grouping
  end
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
