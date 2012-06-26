class MyprojectsController < ApplicationController
  unloadable
  
  def index
    @user = User.current
    @projects = Project.find(:all, :include => [:users, :members],
                                   :conditions => ["#{Project.table_name}.status = ?", Project::STATUS_ACTIVE])
    @projects.select! {|p| p.members.map(&:user_id).include? @user.id}
    
    # bellow was not working from Redmine 2.0.I have no idea...
    #@projects = Project.find(:all, :include => [:users, :members],
    #                               :conditions => ["#{Member.table_name}.user_id = ? AND #{Project.table_name}.status = ?", @user, Project::STATUS_ACTIVE])

    @title = "#{l(:myprojects)} (#{@user.name})"
  end
end

