class Ability
  include CanCan::Ability

  def initialize(user)
    # 未ログインユーザーの場合、権限はなし
    return unless user

    if user.role == 'admin'
      # 管理者はすべての操作が可能
      can :manage, :all
    else
      # 通常ユーザーは自分のタスクだけ操作が可能
      can [:read, :create, :update], Todo, user_id: user.id
      cannot :destroy, Todo # 削除は許可をしない

      # indexアクションに対するアクセス許可
      can :read, Todo, user_id: user.id
    end
  end
end
