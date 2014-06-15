Premailer::Rails.config.merge!(
    :input_encoding => 'UTF-8',
    :preserve_styles => true,
    :generate_text_part => false,
    :adapter => 'nokogiri'
)
