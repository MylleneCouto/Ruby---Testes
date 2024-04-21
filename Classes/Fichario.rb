require 'smarter_csv'
require_relative 'Aluno'

class Fichario
  attr_accessor :alunos, :arquivo

  def initialize(url)
    @alunos = []
    @arquivo = SmarterCSV.process(url)

    @arquivo.each do |linha|
      aluno_aux = is_new_aluno(linha)

      if aluno_aux == -1
        aluno_aux = Aluno.new(linha[:matricula])
        add_aluno(aluno_aux)
      end

      aluno_aux.add_nota(linha[:nota], linha[:cod_disciplina], linha[:carga_horaria], linha[:cod_curso])
    end
  end

  def add_aluno(aux)
    @alunos << aux
    aux
  end

  def is_new_aluno(aux)
    low = 0
    high = @alunos.length - 1

    while low <= high
      mid = (low + high) / 2
      chute = @alunos[mid].matricula

      if chute == aux[:matricula]
        return @alunos[mid]
      elsif chute > aux[:matricula]
        high = mid - 1
      else
        low = mid + 1
      end
    end
    -1
  end

  def show_arquivo
    puts '------O CR dos Alunos é: ------'

    @alunos.each do |i|
      puts "#{i.matricula} - #{i.cr}"
    end
  end
end
