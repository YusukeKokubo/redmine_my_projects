class MyprojectsController < ApplicationController
  unloadable
  
  def index
    @projects = Project.find(:all, :include => [:users, :members],
                                   :conditions => ["#{Member.table_name}.user_id = ? AND #{Project.table_name}.status = ?", User.current.id, Project::STATUS_ACTIVE])
  end
end

