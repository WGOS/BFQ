local function listen()
    while true do
        local senderId, message = rednet.receive("bfq-slave")
        shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/quarry.lua " .. message)
    end
end

listen()