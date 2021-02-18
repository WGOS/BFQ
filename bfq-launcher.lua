local mode = ...
local modes = { "transceiver", "receiver" }

if mode == nil then
    print("No mode selected.\nAvailable modes:")
    for i=1,table.getn(modes) do
        print("\t" .. modes[i])
    end
    
    return 1
end