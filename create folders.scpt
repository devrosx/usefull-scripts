tell application "Finder" to set ptd to POSIX path of (choose folder with prompt "File Location:" default location (path to desktop))

tell application "Mail"
	set theMessages to selection
	repeat with theMessage in theMessages
		set theText to subject of theMessage
		set AList to every mail attachment of theMessage
		--create folders
		set theFile to ptd & theText & (theText as string)
		set savepath to "'" & ptd & theText & "'"
		tell application "Finder"
			make new folder at POSIX file ptd with properties {name:theText}
		end tell
		do shell script "chmod -R 777 " & savepath
		repeat with aFile in AList
			set Filepath to ptd & theText & "/" & (name of aFile)
			save aFile in (POSIX file Filepath) as native format
		end repeat -- next file
	end repeat
end tell
