def convert_pdf_to_page
  temp_pdf = Tempfile.new('articles')
  temp_pdf << page.source.force_encoding('UTF-8')
  reader = PDF::Reader.new(temp_pdf)
  pdf_text = reader.pages.map(&:text)
  page.driver.response.instance_variable_set('@body', pdf_text)
end

Given "I am on the $n page" do |arg1|
  visit send("#{arg1}_path")
end

When(/^I press "([^"]*)" button$/) do |arg1|
	click_link_or_button(arg1)
end

And "I will press $n link" do |arg1|
	click_link_or_button(arg1)
end

Then "I should see $n" do |arg1|
	expect(page).to have_content(arg1)
end

And "I will press first city" do
	city = City.order(:name)
	click_link_or_button(city[0].id)
end

Then "I see pdf" do
	convert_pdf_to_page
	page.should have_content('Relatório de Comparação')
end
