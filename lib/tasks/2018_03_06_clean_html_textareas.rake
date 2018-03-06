require "#{Rails.root}/app/helpers/html_to_string_helper"

namespace :'2018_03_06_clean_html_textareas' do
  task clean: :environment do
    include ActionView::Helpers::TextHelper
    include HtmlToStringHelper
    TypeDeChamp.where(type_champ: "textarea").each do |tdc|
      tdc.champ.where("value like '%<%'").each do |champ|
        champ.update_column(:value, html_to_string(champ.value))
      end
    end
  end
end
