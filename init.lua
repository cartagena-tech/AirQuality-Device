--[[ este archivo por el momento contiene la lectura de los sensores
y sube los datos al servidor.
]]--
dofile("peticionHttp.lua")
pulsador=2 -- el pulsador ambia la fecha
hora=20190213  -- fecha simulada , se puede agregar un reloj de tiempo real o tomar la hora del servidor
gpio.mode(pulsador,gpio.INPUT,gpio.PULLUP)
tmr.alarm(0, 1000, 1, function() -- el temporizador verifica el estado del pulsador cada 1 segundo
	if gpio.read(pulsador)==0 then
		hora=hora+1
		print(hora)
	end

end)

tmr.alarm(2, 30000, 1, function()
pin = 1
status, temp, humi= dht.read(pin)
--hora="20190212"
if status == dht.OK then
	print("hora: "..hora)
    print("DHT Temperature:"..temp..";".."Humidity:"..humi)
    tmr.stop(0)
    tmr.stop(2)
    peticion(temp,humi,tostring(hora)) -- despues de ejecutar la peticion se vuelven a leer los sensores
elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error." )
elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out." )
end

end)
