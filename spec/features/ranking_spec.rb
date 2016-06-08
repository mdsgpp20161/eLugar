require 'rails_helper'
require_relative '../support/ranking_form'

feature 'ranking' do
	let(:ranking_form) { RankingForm.new }

	scenario 'view options' do
		visit('/ranking')
		expect(page).to have_content
	end

	scenario 'ranking view by population' do
		ranking_form.view_ranking_by('População Estimada 2015')
		expect(page).to have_content()
	end

	scenario 'ranking view by demographic density' do
		ranking_form.view_ranking_by('Densidade Demográfica')
		expect(page).to have_content()
	end

	scenario 'ranking view by city area' do
		ranking_form.view_ranking_by('Tamanho da Cidade')
		expect(page).to have_content()
	end				

	scenario 'ranking view by fleet' do
		ranking_form.view_ranking_by('Transporte')
		expect(page).to have_content()
	end					

	scenario 'ranking view by idh' do
		ranking_form.view_ranking_by('IDH')
		expect(page).to have_content()
	end

	scenario 'ranking view by gini' do
		ranking_form.view_ranking_by('Índice de Gini')
		expect(page).to have_content()
	end

	scenario 'ranking view by health' do
		ranking_form.view_ranking_by('Índice de Saúde')
		expect(page).to have_content()
	end

	scenario 'ranking view by violence' do
		ranking_form.view_ranking_by('Índice de Gini')
		expect(page).to have_content()
	end

end					
