class MyprojectsController < ApplicationController
  unloadable
  
  def index
    @user = User.current
    @projects = Project.find(:all, :include => [:users, :members],
                                   :conditions => ["#{Member.table_name}.user_id = ? AND #{Project.table_name}.status = ?", @user, Project::STATUS_ACTIVE])

    @title = "#{l(:myprojects)} (#{@user.name})"
  end
end

