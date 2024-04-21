class Aluno
  attr_accessor :matricula, :carga_horaria_total, :cr, :disciplinas

  def initialize(matricula)
    @disciplinas = []
    @matricula = matricula
    @carga_horaria_total = 0
    @cr = 0
  end

  def add_nota(nota, disciplina, carga_horaria, curso)
    @disciplinas << { nota: nota, codigo: disciplina, cargahoraria: carga_horaria, curso: curso }
    atualiza_cr(nota, carga_horaria)
    @carga_horaria_total += carga_horaria
  end

  def atualiza_cr(nota, carga_horaria)
    @cr = ((@cr * @carga_horaria_total) + (nota * carga_horaria)) / (carga_horaria_total + carga_horaria)
  end
end
