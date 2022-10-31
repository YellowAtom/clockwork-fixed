
Clockwork.json = Clockwork.kernel:NewLibrary("Json")

function Clockwork.json:Encode(tableToEncode)
	return util.TableToJSON(tableToEncode)
end

function Clockwork.json:Decode(stringToDecode)
	return util.JSONToTable(stringToDecode)
end
