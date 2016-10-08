#!/usr/bin/lua
local json = require('json')

file = 'guests.txt'
kicked = 'kicked.txt'
guests = {}
cont = 0;

function toJson(data, file)
	local x = io.open(tostring(file), 'a')
	x:write(json.encode(data))
	x:close()
end

function fileWriter(data, file) 
	local x = io.open(tostring(file), 'w')
	x:write(data)
	x:close()
end

function anIndexOf(t,val)
    for k,v in ipairs(t) do 
        if v == val then return k end
    end
end

function registerGuest()
	os.execute("clear")
	
	io.write("Type your name: ")
	local name = io.read()
	io.write("Type your cpf: ")
	local cpf = io.read()
	
	local data = {Name=name, Cpf=cpf}
	table.insert(guests, data)
	cont = cont + 1
		
	toJson(data, file)
end

function kickGuest()
	local data
	local new_guests = {}
	local to_remove = nil
	
	fileWriter("", file)

	io.write("Type the guest's cpf: ")
	local cpf = io.read()
	io.write("What did he do?: ")
	local reason = io.read()
	
	for i=1, cont do
		if (guests[i].Cpf == cpf) then
            data = {Name=guests[i].Name, Cpf=guests[i].Cpf, Reason=reason}
			to_remove = guests[i]
        else 
			table.insert(new_guests, guests[i])
			toJson(guests[i], file)
        end
	end
	
	if to_remove ~= nil then
		guests = new_guests
		toJson(data, kicked)
		cont = cont - 1
	end

end

function searchGuest()
	io.write("Type the guest's cpf: ")
	local cpf = io.read()
	
	for i, guest in ipairs(guests) do
		if string.find(guest.Cpf, cpf) then
			print('Name:', guest.Name)
			print('Cpf:', guest.Cpf)
			print ""
		end
	end
end

function show(file)
	local x = io.open(tostring(file), 'r')
	print(x:read())
	x:close()
	print ""
end

function deleteEverything()
	fileWriter("", file)
	fileWriter("", kicked)
	guests = {}
	cont = 0
	os.execute("clear")
end

repeat	
	print ("Choose one of the following options:\n")
	print("1.Register guest\n")
	print("2.Kick guest\n")
	print("3.Search a guest\n")
	print("4.Show guests\n")
	print("5.Show kicked\n")
	print("6.Delete everything\n")
	print("0.Leave\n")
	
	local op = io.read()
	os.execute("clear")
	
	if (op == '1') then registerGuest() end
	if (op == '2') then kickGuest() end
	if (op == '3') then searchGuest() end
	if (op == '4') then show(file) end 
	if (op == '5') then show(kicked) end
	if (op == '6') then deleteEverything() end
until op == '0'
