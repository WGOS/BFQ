local mode, command = ...
local modes = { "master", "slave" }

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
    shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/bfq-master.lua " .. command)
end

local function runSlave()
    print("Running in slave mode")
    shell.run("wget run https://raw.githubusercontent.com/WGOS/BFQ/master/bfq-slave.lua")
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

if not contains(mode) then
    print("Unknown mode selected")
    listModes()
    return 2
end

rednet.open(getModemSide())

if mode == "master" then
    runMaster()
elseif mode == "slave" then
    runSlave()
end