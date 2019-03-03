wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="CVRELECTRONIC"--"Velocilabs"
station_cfg.pwd="CVR9401mcm02"--"73182516"
station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()
--print(wifi.sta.status())
cont=0
conexionWifi=false
function peticion(temperatura,humedad,hora)
  http.get('https://cartagenaTech.cvrelectronica.com/uploadDatos.php?temperatura='..temperatura..'&humedad='..humedad..'&hora='..hora,
  nil,function(code, data)
        if (code < 0) then
          print("HTTP request failed")
          tmr.start(2)
        else
          print(code, data)
          tmr.start(0)
          tmr.start(2)
        end
    end)
end
tmr.alarm(1, 1000, 1, function()
   if wifi.sta.getip()==nil then
   cont=cont+1
    print("Esperando wifi: ["..cont.."]")
      if cont>20 then
        tmr.stop(1) 
      end
        
   else
      print("Direccion IP de la estacion "..wifi.sta.getip())
      print("conectado")
      tmr.stop(1)
   end
   end)


