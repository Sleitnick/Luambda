--[[

	Author: Stephen Leitnick

	Lua Lambda execution

	This script is responsible for calling the handler script managed
	by the user. The lambda event is JSON-decoded, sent to the handler,
	JSON-encodes the response from the handler, and then passes on the
	response.

--]]

local FILENAME_OUT = "/tmp/lua_result.log"
local FILENAME_ERR = "/tmp/lua_result_err.log"

local root, handler, eventJson = ...

-- Add runtime to package path:
package.path = "/opt/runtime/?.lua;" .. package.path
local json = require("json")

-- Add task root to package path:
package.path = root .. "/?.lua;" .. package.path

local function writeFile(filename, contents)
	local file, err = io.open(filename, "w")
	file:write(contents)
	file:close()
end

local function runModule()
	-- Run in protected mode
	local dotIndex = handler:find("%.")
	local moduleName = handler:sub(1, dotIndex - 1)
	local funcName = handler:sub(dotIndex + 1)
	local event = json.decode(eventJson)
	local module = require(moduleName)
	local result = module[funcName](event)
	return json.encode(result)
end

local success, result = pcall(runModule)
if (success) then
	writeFile(FILENAME_OUT, result)
else
	local resultErr = json.encode({
		errorMessage = (result == nil and "UNKNOWN" or tostring(result));
		errorType = "LuaError";
	})
	writeFile(FILENAME_ERR, resultErr)
end