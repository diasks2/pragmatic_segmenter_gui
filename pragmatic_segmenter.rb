# encoding: utf-8

Shoes.setup do
  gem 'pragmatic_segmenter', '0.3.3'
end

require 'pragmatic_segmenter'

LANGUAGE_CODES = {
  'en' => 'English',
  'de' => 'German',
  'es' => 'Spanish',
  'fr' => 'French',
  'it' => 'Italian',
  'ja' => 'Japanese',
  'el' => 'Greek',
  'ru' => 'Russian',
  'ar' => 'Arabic',
  'am' => 'Amharic',
  'hi' => 'Hindi',
  'hy' => 'Armenian',
  'fa' => 'Persian',
  'my' => 'Burmese',
  'ur' => 'Urdu',
  'nl' => 'Dutch',
  'pl' => 'Polish',
  'zh' => 'Chinese',
  nil  => 'Other'
}

Shoes.app(title: "Pragmatic Segmenter") do
  background "#fff"
  border("#F27A24", strokewidth: 6)

  stack(margin: 12) do
    flow do
      para "Choose the UTF-8 text file you would like to segment:"
    end
    flow do
      @select_file = button "Choose File"
    end
    flow do
      para "Enter the file path and name of the new file that will be created (i.e. /Desktop/segmented_text.txt):"
    end
    flow do
      @file_output_path = edit_line width: 500
    end
    flow do
      para "Select a Language:"
    end
    flow do
      @language = list_box items: LANGUAGE_CODES.values
    end
    flow do
      @push = button "Create Segmented File"
    end
    @note = para ''
    @push.click do
      @note.replace ''
      @text = File.open(@file_input_path, "r:UTF-8", &:read)
      File.open(@file_output_path.text(), 'w') { |f| f.write(PragmaticSegmenter::Segmenter.new(text: @text, language: LANGUAGE_CODES.key(@language.text())).segment.join("\n")) }
      @note.replace "Finished"
    end

    @select_file.click do
      @file_input_path = ask_open_file
    end
  end
end