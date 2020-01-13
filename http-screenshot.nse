
description = [[
Gets a screenshot from the host
]]

author = "Ryan Linn <rlinn at trustwave.com>, Tudor Enache"

license = "GPLv2"

categories = {"discovery", "safe"}

-- Updated the NSE Script imports and variable declarations
local shortport = require "shortport"

local stdnse = require "stdnse"

-- Process services that are either running on 80, 443 or ones that are classified as http(s)
portrule = shortport.port_or_service({80,443},{"http","https"})

action = function(host, port)
	-- Check to see if ssl is enabled, if it is, this will be set to "ssl"
	local service_prefix = port.service

	-- Screenshots will be called screenshot-namp-<IP>:<port>.png

        local filename = "screenshot-nmap-" .. service_prefix .. host.ip .. ":" .. port.number .. ".png"

	-- Execute the shell command timeout 10 wkhtmltoimage <url> <filename>
	local cmd = "timeout 10 wkhtmltoimage --height 768 -n " .. service_prefix .. "://" .. host.ip .. ":" .. port.number .. " " .. filename .. " 2>/dev/null >/dev/null"
	
	local ret = os.execute(cmd)

	-- If the command was successful, print the saved message, otherwise print the fail message
	local result = "failed (verify wkhtmltoimage is in your path)"

	if ret then
		result = "Saved to " .. filename
	end

	-- Return the output message
	return stdnse.format_output(true,  result)

end
