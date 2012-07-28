local Y in
	local Res in
		local Pi in
			thread
				Pi = 3.14
				Res = Pi+Y
			end

			thread
				{Delay 10000}
				Y = 6.86
				{Browse Res}
			end
		end
	end
end
