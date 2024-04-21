require 'rspec'
require_relative '../Classes/Aluno'

RSpec.describe Aluno do
  let(:aluno) { Aluno.new('100') }
  let(:aluno2) { Aluno.new('abc') }

  describe '#initialize' do
    it 'Cria um novo Aluno com sucesso' do
      expect(aluno.matricula).to eq('100')
      expect(aluno.carga_horaria_total).to eq(0)
      expect(aluno.cr).to eq(0)
      expect(aluno.disciplinas).to be_empty
    end

    it 'Cria um novo Aluno com matricula que não é um numero inteiros' do
      expect(aluno2.matricula).to eq('abc')
      expect(aluno2.carga_horaria_total).to eq(0)
      expect(aluno2.cr).to eq(0)
      expect(aluno2.disciplinas).to be_empty
    end
  end

  describe '#add_nota' do
    it 'adiciona uma nova nota e atualiza o cr com sucesso' do
      aluno.add_nota(85, 'CAlC01', 64, 'Computação')
      expect(aluno.disciplinas.size).to eq(1)
      expect(aluno.disciplinas.first[:nota]).to eq(85)
      expect(aluno.disciplinas.first[:codigo]).to eq('CAlC01')
      expect(aluno.disciplinas.first[:cargahoraria]).to eq(64)
      expect(aluno.disciplinas.first[:curso]).to eq('Computação')
      expect(aluno.carga_horaria_total).to eq(64)
      expect(aluno.cr).to eq(85)
    end
  end

  describe '#atualiza_cr' do
    it 'Atualiza o CR Corretamente' do
      aluno.atualiza_cr(85, 64)
      aluno.carga_horaria_total = 64
      aluno.atualiza_cr(70, 64)

      expect(aluno.cr).to eq((85 * 64 + 70 * 64) / 128)
    end

    it 'Atualiza o CR com a carga horaria negativa' do
      aluno.atualiza_cr(85, -35)

      expect(aluno.cr).to raise_error('Carga Horária não pode ser negativa')
    end

    it 'Atualiza o CR com a carga horaria sendo 0 ' do
      aluno.atualiza_cr(85, 0)

      expect(aluno.cr).to raise_error('Carga Horária não pode ser zero')
    end


    it 'Atualiza o CR com a nota negativa' do
      aluno.atualiza_cr(85, -35)

      expect(aluno.cr).to raise_error('Carga Horária não pode ser negativa')
    end
  end
end
