ALIVE_Core_JSON = require("ALIVE_Core_JSON.lua");

ALIVE_FileUtils_CurrentlyActiveSaveIndex = 1;
ALIVE_FileUitls_SubDirectory = "AliveInside\\"
ALIVE_FileUtils_SavesDirectory = ALIVE_FileUitls_SubDirectory .. "Saves\\"

--Decodes a JSON file and returns the raw object. Useful for non-standard reads.
ALIVE_Core_FileUtils_DecodeJSONFile = function(fileName) 
    local theFile = (io.open)(fileName, "r") --Open the file
    if theFile == nil then
        return nil;
    end

    local content = theFile:read("*all") --Read the file's content
    theFile:close()
    
    return ALIVE_Core_JSON.decode(content) --Return the decoded file.
end

ALIVE_Core_FileUtils_Init = function()
    if not ALIVE_Core_FileUtils_DirectoryExists(ALIVE_FileUitls_SubDirectory) then --Create File Tree
        print("Alive Inside SubDirectory Not Found! Creating...");
        os.execute("mkdir ".. ALIVE_FileUtils_SavesDirectory);  
    end

    if not ALIVE_Core_FileUtils_FileExists(ALIVE_FileUitls_SubDirectory.."options.json") then
        print("Options file not found! Creating...")
        local gameOptions = (io.open)(ALIVE_FileUitls_SubDirectory.."options.json", "w");
        gameOptions:write("This is a test file from Alive Inside!");
        gameOptions:close();
    end

    print("FileUtils Initialization Complete.") --We now have all requisite files and are ready to use them.
end

ALIVE_Core_FileUtils_FileExists = function(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

ALIVE_Core_FileUtils_DirectoryExists = function(directory)
    return ALIVE_Core_FileUtils_FileExists(directory)
end