require 'redmine'

Redmine::Plugin.register :redmine_my_projects do
  name 'Redmine MyProjects Plugin'
  author 'Yusuke Kokubo'
  description 'This is a plugin for Redmine.'
  version '0.0.1'

  menu :top_menu,
	   :myprojects,
	   {:controller => 'myprojects',
		:action => 'index'},
	   :caption => :myprojects
end

