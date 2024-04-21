require_relative 'Classes/Fichario'

url = File.expand_path('notas.csv')
fichario = Fichario.new(url)
fichario.show_arquivo
