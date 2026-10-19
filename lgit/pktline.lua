local M = {}

M.FLUSH = "0000"
M.DELIM = "0001"
M.RESPONSE_END = "0002"

function M.encode(payload)
	local length = #payload + 4

	if length > 65520 then error("Payload length was too large! Larger than 65516: " .. string.format("%i", length - 4)) end


	return string.format("%04x", length) .. payload
end

function M.line(text)
	return M.encode(text .. "\n")
end

return M