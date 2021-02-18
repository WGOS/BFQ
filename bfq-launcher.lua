local mode = ...
local args = { ... }
local modes = { "master", "slave", "slave-start" }

local function getModemSide()
    for _, side in pairs(rs.getSides()) do
        if peripheral.isPresent(side) and peripheral.getType(side) == "modem" then return side end
    end
end

local function contains(arr, item)
    for key, value in pairs(arr) do
        if value == item then return key end
    end
    return false
end

local function runMaster()
    print("Running in master mode")

    if args[2] == nil then
        print("No command provided")
        return 3
    end

    if args[3] == nil then
        print("No channel provided")
        return 4
    end

    shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/bfq-master.lua \"" .. args[2] .. "\" " .. args[3])
end

local function runSlave()
    print("Running in slave mode")

    if args[3] == nil then
        print("No channel provided")
        return 4
    end

    shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/bfq-slave.lua " .. args[2])
end

local function addStartup()
    print("Adding slave mode file to startup")
    fs.delete("/startup")
    local file = fs.open("/startup", "w")
    file.writeLine("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/bfq-launcher.lua slave " .. args[2])
    file.close()
end

local function listModes()
    print("Available modes:")
    for i=1,table.getn(modes) do
        print("\t" .. modes[i])
    end
end

if mode == nil then
    print("No mode selected")
    listModes()
    return 1
end

if not contains(modes, mode) then
    print("Unknown mode selected")
    listModes()
    return 2
end

local modemSide = getModemSide();
rednet.open(modemSide)

if mode == "master" then
    return runMaster()
elseif mode == "slave" then
    return runSlave()
elseif mode == "slave-start" then
    return addStartup()
end

rednet.close(modemSide)