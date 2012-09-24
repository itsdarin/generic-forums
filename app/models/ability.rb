class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.guest
    can do |action, subject_class, subject|
      can_result = false
      negated    = false
      remote_ids = [subject.id]
      remote_ids.push subject.ghost.id if subject.respond_to?(:ghost)
      action_permissions = user.permissions.where(
                                                  :action => aliases(action),
                                                  :type => subject_class.to_s,
                                                  :remote_id => remote_ids
                                                )
      if action_permissions.any?
        can_result = action_permissions.any? do |permission|
          negated = true if permission.negate
          can_result ||= true
        end
      end
      #if subject.respond_to?(:ghost)
      #  can_result = subject.ghost.permissions.where({
      #    :action   => action,
      #    :type     => subject_class.to_s,
      #    :group_id => user.group_ids
      #  }).any? do |permission|
      #    negated = true if permission.negate
      #    can_result ||= true
      #  end
      #end
      can_result and not negated
    end
  end

  private

  def aliases(action)
    aliases = [action]
    aliases << :manage
    case action
    when :edit_own_post
      aliases << :edit_post
    when :delete_own_post
      aliases << :delete_post
    end
    aliases
  end
end
