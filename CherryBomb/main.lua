CHB = SMODS.current_mod

function CHB.load_file(file)
    local chunk, err = SMODS.load_file(file, "chb_mods")
    if chunk then
        local ok, func = pcall(chunk)
        if ok then
            return func
        else
            sendWarnMessage("Failed to process file: " .. func, "chb_mods")
        end
    else
        sendWarnMessage("Failed to find or compile file: " .. tostring(err), "chb_mods")
    end
    return nil
end

function CHB.load_dir(directory)
    local files = NFS.getDirectoryItems(CHB.path .. "/" .. directory)
    local regular_files = {}

    for _, filename in ipairs(files) do
        local file_path = directory .. "/" .. filename
        sendTraceMessage("Loading file: "..file_path, "CherryBombMainLogger")
        if file_path:match(".lua$") then
            if filename:match("^_") then
                CHB.load_file(file_path)
            else
                table.insert(regular_files,file_path)
            end
        end
    end

    for _, file_path in ipairs(regular_files) do
        CHB.load_file(file_path)
    end
end

CHB.load_dir("jokers")
-- SMODS.Sound:register_global()

