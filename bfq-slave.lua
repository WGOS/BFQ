local channel = ...

local function listen()
    while true do
        print("[BFQ] Ready to receive commands at channel" .. channel)
        local senderId, message = rednet.receive("bfq-slave-" .. channel)
        shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/quarry.lua " .. message)
    end
end

listen()