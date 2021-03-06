module ExamsHelper
  def select_drug_in
    select_tag "drug_ins", options_for_select( \
        @drug_ins.map{ |d| [select_drug_in_text(d), d.id, \
        { data: {"subtext"=> select_drug_in_subtext(d), \
          "sale" => d.sale_price_per_unit, "default-usage" => default_drug_usage_id(d) } } ] } \
      ), \
      class: "form-control", data: { 'live-search' => true }
  end

  def select_drug_in_form(f)
    f.select :drug_in_id, options_for_select( \
      @drug_ins.map{ |d| [select_drug_in_text(d), d.id, \
      { data: {"subtext" => select_drug_in_subtext(d), \
        "sale" => d.sale_price_per_unit, "default-usage" => default_drug_usage_id(d) } } ] }, \
      f.object.drug_in_id \
    ), \
    {}, class: "selectpicker form-control", data: {"live-search" => true }
  end

  def select_drug_usage
    select_tag "drug_usages", options_for_select( \
      @drug_usages.map{ |d| [d.code, d.id, \
      { data: {"subtext"=> d.text } } ] } \
    ), \
    class: "form-control", data: { 'live-search' => true }
  end

  def select_drug_usage_form(f)
    f.select :drug_usage_id, options_for_select( \
      @drug_usages.map{|d| [d.code, d.id, \
      { data: {"subtext"=> d.text } } ] }, \
      f.object.drug_usage_id \
    ), \
    {}, class: "selectpicker form-control", data: {"live-search" => true }
  end

  def paid_status(exam)
    exam.paid_status ? "DONE" : "NO"
  end

  def paid_status_class(exam)
    exam.paid_status ? "stock-in" : "stock-out"
  end

  def can_edit_revenue?(exam)
    action_name == "show"
  end

  def examiner_name(exam)
    result = "N/A"
    
    if exam.examiner
      examiner = exam.examiner
      result = examiner.display_name if examiner.display_name.present?
    end

    result
  end  

  private
    def render_panel(template, locals)
      render partial: template, layout: "global/panel/layout",\
        locals: locals
    end

    def render_panel_locals(id, headerKey)
      return {  id: id,\
                toggleTarget: "#{id}Body",\
                panelClass: "default",\
                headerTextKey: headerKey }
    end

    def select_drug_in_text(drug_in)
      "#{drug_in.drug.name} (Exp: #{th_date_format(drug_in.expired_date)})"
    end

    def select_drug_in_subtext(drug_in)
      "Bal. #{drug_in.balance} Sale price. #{drug_in.sale_price_per_unit}"
    end

    def default_drug_usage_id(drug_in)
      if drug_in.drug.drug_usage
        drug_in.drug.drug_usage.id
      else
        nil
      end
    end    
end
