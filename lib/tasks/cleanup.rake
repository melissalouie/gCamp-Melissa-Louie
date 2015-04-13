
task cleanup: [:environment] do

  desc 'clean up data'

    # Delete memberships if its project or user has been deleted.
    Membership.all.each do |membership|
      membership.destroy if membership.project_id.nil? || membership.user_id.nil?
    end

    # Delete comments if its task has been deleted.
    Comment.where(task_id: nil).destroy_all

    # Delete tasks if its project has been deleted.
    Task.where(project_id: nil).destroy_all

end
