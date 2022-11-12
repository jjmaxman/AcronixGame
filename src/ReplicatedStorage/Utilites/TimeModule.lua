local module = {}
function module.SecondsToHours(seconds)
	local newHour
	if tonumber(seconds) then
		newHour = seconds/3600
	else
		error("Number was not inputted.")
		return 
	end

	return newHour
end

function module.SecondsToMinutes(seconds)
	local newMinute
	if tonumber(seconds) then
		newMinute = seconds/60
	else
		error("Number was not inputted")
		return
	end

	return newMinute
end

function module.SecondsToDays(seconds)
	local newDay
	if tonumber(seconds) then
		newDay = seconds/86400
	else
		error("Number was not inputted")
		return
	end

	return newDay
end

function module.MinutesToSeconds(minutes)
	local newSecond
	if tonumber(minutes) then
		newSecond = minutes * 60
	else
		error("Number was not inputted")
		return 
	end
	return newSecond
end

function module.MinutesToHours(minutes)
	local newHour
	if tonumber(minutes) then
		newHour = minutes/60
	else
		error("Number was not inputted")
		return
	end
	return newHour
end

function module.MinutesToDays(minutes)
	local newDay
	if tonumber(minutes) then
		newDay = minutes/1440
	else
		error("Number was not inputted")
		return 
	end
	return newDay
end

function module.HoursToMinutes(hours)
	local newMinute
	if tonumber(hours) then
		newMinute = hours/60
	else
		error("Number was not inputted")
		return
	end
	return newMinute
end

function module.HoursToSeconds(hours)
	local newSecond
	if tonumber(hours) then
		newSecond = hours * 3600
	else
		error("Number was not inputted")
		return
	end
	return newSecond
end

function module.HoursToDays(hours)
	local newDay
	if tonumber(hours) then
		newDay = hours / 24
	else
		error("Number was not inputted")
		return
	end
	return newDay
end

function module.DaysToSeconds(days)
	local newSecond 
	if tonumber(days) then
		newSecond = days * 86400
	else
		error("Number was not inputted")
		return
	end
	return newSecond
end

function module.DaysToMinutes(days)
	local newMinute 
	if tonumber(days) then
		newMinute = days * 1440
	else
		error("Number was not inputted")
		return
	end

	return newMinute
end

function module.DaysToHours(days)
	local newHour
	if tonumber(days) then
		newHour = days * 24
	else
		error("Number was not inputted")
		return
	end
	return newHour
end

return module