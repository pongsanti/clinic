class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private
    def manager_or_higher?
      user.manager? or user.admin?
    end

    def doctor_or_higher?
      user.doctor? or user.manager? or user.admin?
    end

end