require 'redmine'

Redmine::Plugin.register :redmine_my_projects_plugin do
  name 'Redmine MyProjects Plugin plugin'
  author 'Yusuke Kokubo'
  description 'This is a plugin for Redmine.'
  version '0.0.1'

  menu :top_menu,
	   :myprojects,
	   {:controller => 'myprojects',
		:action => 'index'},
	   :caption => :myprojects
end

