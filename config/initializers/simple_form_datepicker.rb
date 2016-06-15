module SimpleForm
  module Inputs
    class DatePickerInput < SimpleForm::Inputs::StringInput
      def input_html_options
        value = object.send(attribute_name)
        options = {
          value: value.nil?? nil : I18n.localize(value),
          data: { behaviour: 'datepicker' },
          class: 'form-control'
        }
        super.merge options
      end
    end
  end
end