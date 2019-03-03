--[[
Este archivo contiene el codigo que lee los valores PM2.5 del sensor
se pueden leer todos los valores que el sensor arroja simplemente
accediendo al dato en la direcion que le corresponde en la trama
]]--
gpio.mode(5,gpio.OUTPUT) -- SENSOR ENABLE
gpio.write(5,1) 
uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 0) -- el sensor arroja los batos en tramaño de bytes
index=0
a={}
uart.on("data", 32, -- todos los datos se reciben en un arreglo de 32 bytes
  function(data)
    print("Datos desde el uart:", data)
    if data=="****salir del programa lua******" then --para salir del modo uart
      uart.on("data") -- uart off
      --print("Tamaño tabla: "..table.getn(a))
      index=0
    else
    	pm25msb=string.byte(data,7) -- los valores pm2.5 se alojan en las posiciones 7 y 8 de la trama
    	pm25lsb=string.byte(data,8)
    	pm25msbDes=pm25msb*256
    	sum=pm25msbDes+pm25lsb
    	--x=bit.lshift(msb,8)
    	print("Dato sin desplazar MSB: "..pm25msb
    		.." Dato desplazado MSB: "..pm25msbDes
    		.." Dato LSB: "..pm25lsb
    		.." Dato suma: "..sum) --[[ este sería el valor leido (suma de los 2 bytes)
        El tamaño de los regirtros del esp8266 es de 32bits por lo que el valor proveniente
        del sensor entra en el rango (16 bits) sin problema
      ]]--
    	--index=index+1
    end
end, 0)
