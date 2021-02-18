local listen()
    while true do
        local senderId, message = rednet.receive("bfq-slave")
        shell.run(message)
    end
end