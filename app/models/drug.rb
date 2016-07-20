class Drug < ActiveRecord::Base

  belongs_to :drug_usage
  belongs_to :store_unit

  has_many :drug_ins

  class << self
    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(name trade_name)
    end

    def drug_ins_exist()
      joins(:drug_ins).where("drug_ins.drug_id is not null").distinct.order("name")
    end

  end

  def recal_balance
    self.balance = self.drug_ins.sum(:balance)
    save
  end
end
