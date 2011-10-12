module MyprojectsHelper
    
  def make_send_body(project)
    return "" unless project.module_enabled? :backlogs

    # Sprints
    # ※BacklogsプラグインのSprintは将来的にVersionと同一視されなくなるので注意
    sprints = RbSprint.find(:all, 
                           :order => 'sprint_start_date ASC, effective_date ASC',
                           :conditions => ["project_id = ?", project.id])

    # rfp hours
    total_rfp_hours = project.custom_values[0] ? project.custom_values[0].to_s.to_f : 0.0

    # estimated hours
    total_estimated_hours = sprints.inject(0.0) do |sum, sprint|
      next sum unless sprint.estimated_hours
      sum + sprint.estimated_hours
    end

    # spent hours
    total_spent_hours = sprints.inject(0.0) do |sum, sprint|
      next sum unless sprint.spent_hours
      sum + sprint.spent_hours
    end

    rate_estimated_vs_rfp   = total_estimated_hours / total_rfp_hours * 100
    rate_spent_vs_rfp       = total_spent_hours     / total_rfp_hours * 100
    rate_spent_vs_estimated = total_spent_hours     / total_estimated_hours * 100

    class_estimated_vs_rfp = "normal"
    class_estimated_vs_rfp = "overtime" if rate_estimated_vs_rfp > 100.0
    class_estimated_vs_rfp = "noplan"   if rate_estimated_vs_rfp.infinite?

    class_spent_vs_rfp = "normal"
    class_spent_vs_rfp = "overtime" if rate_spent_vs_rfp > 100.0
    class_spent_vs_rfp = "noplan"   if rate_spent_vs_rfp.infinite?

    <<-EOF
    <tr class="#{cycle 'odd', 'even'}">
      <td>#{link_to_project(project)}</a></td>
      <td>#{project.custom_values[5].value if project.custom_values[5]}</td>
      <td>#{project.custom_values[6].value if project.custom_values[6]}</td>
      <td class="hour">#{l_hour(total_rfp_hours)}</td>
      <td class="hour">#{l_hour(total_estimated_hours)}</td>
      <td class="hour">#{l_hour(total_spent_hours)}</td>
      <td class="hour #{class_estimated_vs_rfp}">#{l_hour(rate_estimated_vs_rfp)}</td>
      <td class="hour #{class_spent_vs_rfp}">#{l_hour(rate_spent_vs_rfp)}</td>
      <td class="hour">#{l_hour(rate_spent_vs_estimated)}</td>
    </tr>
    EOF
  end

  def l_hour(hour)
    sprintf("%.1f", hour)
  end

end

