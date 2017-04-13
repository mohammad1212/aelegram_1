redis = (loadfile "redis.lua")()
function getaelegramid()
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls')
	local last = 0
    for filename in pfile:lines() do
        if filename:match('aelegram%-(%d+)%.lua') and tonumber(filename:match('aelegram%-(%d+)%.lua')) >= last then
			last = tonumber(filename:match('aelegram%-(%d+)%.lua')) + 1
			end		
    end
    return last
end
local last = getaelegramid()
io.write("Auto Detected aelegram ID : "..last)
io.write("\nEnter Full Sudo ID : ")
local sudo=io.read()
local text,ok = io.open("base.lua",'r'):read('*a'):gsub("aelegram%-ID",last)
io.open("aelegram-"..last..".lua",'w'):write(text):close()
io.open("aelegram-"..last..".sh",'w'):write("while true; do\n$(dirname $0)/telegram-cli-1222 -p aelegram-"..last.." -s aelegram-"..last..".lua\ndone"):close()
io.popen("chmod 777 aelegram-"..last..".sh")
redis:set('aelegram:'..last..':fullsudo',sudo)
print("Done!\nNew aelegram Created...\nID : "..last.."\nFull Sudo : "..sudo.."\nRun : ./aelegram-"..last..".sh")
