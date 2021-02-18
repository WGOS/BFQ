local function listen()
    while true do
        local senderId, message = rednet.receive("bfq-slave")
        shell.run("pastebin run rpXRAZs4 " .. message)
    end
end

listen()