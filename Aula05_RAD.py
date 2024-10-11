import sqlite3
conector = sqlite3.connect("academia.db")
cursor = conector.cursor()
sql = "select * from cadastro"
cursor.execute(sql)
dados = cursor.fetchall()
cursor.close()
conector.close()
print("\nConsulta ao Banco de Dados ‘academia.db’ \n")
print("Dados da tabela ‘cadastro’")
print("-" * 35)
print("{:7} {:20} {:>6}".format("Código", "Nome", "Idade"))
print("-" * 18)
for d in dados:
 print("{:<7} {:20} {:>6}".format(d[0], d[1], d[2])) 
print("-" * 35)
print("Encontrados {} registros".format(len(dados))) 
print("\n\nFim do programa")
