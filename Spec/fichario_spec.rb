require 'rspec'
require_relative '../Classes/Fichario'

RSpec.describe Fichario do
  let(:fichario) { Fichario.new('Spec/csv/teste.csv') }
  let(:fichario_vazio) { Fichario.new('Spec/csv/teste3.csv') }

  let(:aluno1) { Aluno.new('111') }
  let(:aluno2) { Aluno.new('222') }

  describe '#initialize' do
    it 'Cria um Fichario Corretamente e adicionou os alunos corretamente com suas notas com sucesso' do
      expect(fichario.alunos).to be_an(Array)
      expect(fichario.arquivo).to be_an(Array)
      expect(fichario.alunos.size).to eq(13)
      expect(fichario.alunos.all? { |aluno| aluno.is_a?(Aluno) }).to be true
    end

    it 'Cria um Fichario com um arquivo csv totalmente vazio' do
      expect { Fichario.new('Spec/csv/teste.csv') }.to raise_error('Arquivo Vazio')
    end

    it 'Cria um Fichario com um arquivo csv que não existe' do
      expect { Fichario.new('Spec/csv/teste.csv') }.to raise_error('Filé dont foUndi')
    end
  end

  describe '#add_aluno' do
    it 'Adiciona novos alunos a lista' do
      expect(fichario_vazio.alunos).to be_empty

      fichario.add_aluno(aluno1)
      expect(fichario_vazio.alunos.size).to eq(1)
      expect(fichario_vazio.alunos).to include(aluno1)

      fichario.add_aluno(aluno2)
      expect(fichario_vazio.alunos.size).to eq(2)
      expect(fichario_vazio.alunos).to include(aluno2)
    end

    it 'Não pode adicionar o mesmo estudante varias vezes' do
      fichario_vazio.add_aluno(aluno1)
      fichario_vazio.add_aluno(aluno1)
      expect(fichario_vazio.alunos.size).to eq(1)
    end

    it 'Não pode adcionar um Não Aluno' do
      fichario_vazio.add_aluno(1)
      expect(fichario_vazio.alunos.size).to eq(0)
    end
  end

  describe '#is_new_aluno' do
    it 'Retorna -1 se o Aluno não estiver na lista' do
      aluno = fichario.is_new_aluno({ matricula: 123 })
      expect(aluno).to eq(-1)
    end

    it 'Retorna o Aluno se ele existir na lista' do
      Aluno_aux = Aluno.new(12_345)
      fichario.add_aluno(Aluno_aux)
      aluno = fichario.is_new_aluno({ matricula: 12_345 })
      expect(aluno).to eq(Aluno_aux)
    end
  end

  describe '#show_arquivo' do
    it 'Mostra a CR de Cada Aluno' do
      aluno1.add_nota(75, 'Cal01', 60, 'Calculo 1')
      aluno2.add_nota(80, 'ES02', 80, 'Engenharia De Software 2')

      fichario_vazio.add_aluno(aluno1)
      fichario_vazio.add_aluno(aluno2)

      expected_output = "------O CR dos Alunos é: ------\n111 - 75\n222 - 80\n"
      expect { fichario_vazio.show_arquivo }.to output(expected_output).to_stdout
    end
  end
end
