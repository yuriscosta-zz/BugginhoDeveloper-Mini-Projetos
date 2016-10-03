#!/usr/bin/lua
local json = require('json')

file = 'convidados.txt'
removidos = 'removidos.txt'
convidados = {}

function cadastrar()
	os.execute("clear")
	
	io.write("Digite o seu nome: ")
	local nome = io.read()
	io.write("Digite o seu cpf: ")
	local cpf = io.read()
	
	local data = {Nome=nome, Cpf=cpf}
	table.insert(convidados, data)
	
	local arq = io.open(file, 'a')
	arq:write(json.encode(data))
	arq:close()
end

function remover()
	local data
	local cont = 1
	
	io.write("Digite o cpf do convidado: ")
	local cpf = io.read()
	io.write("Digite o motivo: ")
	local motivo = io.read()	
	
	for i, convidado in ipairs(convidados) do
		if string.find(convidado.Cpf, cpf) then
			data = {Nome=convidado.Nome, Cpf=convidado.Cpf, Descricao=motivo}
			cont = cont + 1
			print ""
		end
	end
	
	table.remove(convidados, cont)
	
	local arq = io.open(removidos, 'a')	
	arq:write(json.encode(data))
	arq:close()
	
	data = json.encode(convidados)
	local arq = io.open(file, 'w')
	arq:write(data)
	arq:close()
end

function consultar()
	io.write("Digite o cpf do convidado: ")
	local cpf = io.read()
	
	for i, convidado in ipairs(convidados) do
		if string.find(convidado.Cpf, cpf) then
			print('Nome:', convidado.Nome)
			print('Cpf:', convidado.Cpf)
			print ""
		end
	end
end

function listarConvidados()
	local arq = io.open(file, 'r')
	print(arq:read())
	arq:close()
	
	print ""
end

function listarRemovidos()
	local arq = io.open(removidos, 'r')
	print(arq:read())
	arq:close()
	
	print ""
end

function apagar()
	local arq = io.open(file, 'w')
	arq:write()
	arq:close()
	
	arq = io.open(removidos, 'w')
	arq:write()
	arq:close()
	
	convidados = {}
	
	os.execute("clear")
end

repeat	
	print ("Selecione uma das opções abaixo\n")
	print("1.Cadastrar convidado\n")
	print("2.Remover convidado\n")
	print("3.Consultar convidado\n")
	print("4.Listar convidados\n")
	print("5.Listar removidos\n")
	print("6.Apagar Lista\n")
	print("0.Sair\n")
	
	local op = io.read()
	os.execute("clear")
	
	if (op == '1') then cadastrar() end
	if (op == '2') then remover() end
	if (op == '3') then consultar() end
	if (op == '4') then listarConvidados() end 
	if (op == '5') then listarRemovidos() end
	if (op == '6') then apagar() end
until op == '0'
