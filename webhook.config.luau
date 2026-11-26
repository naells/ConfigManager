do
	local C = game:GetService("HttpService");
	local r = "facecard_library.json";
	local N = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	local function v(C)
		C = string.gsub(C, "[^" .. ((N .. "=]")), "");
		return (((C:gsub(".", function(C)
			if C == "=" then
				return "";
			end;
			local r, v = "", (N:find(C) - 1);
			for C = 6, 1, -1 do
				r = r .. ((v % 2 ^ C - v % 2 ^ ((C - 1)) > 0 and "1" or "0"));
			end;
			return r;
		end))):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(C)
			if #C ~= 8 then
				return "";
			end;
			local r = 0;
			for N = 1, 8, 1 do
				r = r + ((C:sub(N, N) == "1" and 2 ^ ((8 - N)) or 0));
			end;
			return string.char(r);
		end));
	end;
	local function t(N, t)
		if type(writefile) ~= "function" then
			t.Text = "Error: Executor not support writefile";
			t.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		t.Text = "Mengunduh file backup JSON...";
		t.TextColor3 = Color3.fromRGB(255, 215, 90);
		task.wait(.05);
		local Q, o = pcall(function()
				return game:HttpGet(N);
			end);
		if not Q or type(o) ~= "string" or #o == 0 then
			t.Text = "Gagal mengunduh file dari URL!";
			t.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		local w, E = pcall(function()
				return C:JSONDecode(o);
			end);
		if not w or type(E) ~= "table" or type(E.looks) ~= "table" then
			t.Text = "Format JSON not valid";
			t.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		local k = {};
		local D = {};
		if type(isfile) == "function" and isfile(r) then
			local N, v = pcall(function()
					return C:JSONDecode(readfile(r));
				end);
			if N and type(v) == "table" then
				k = v;
				for C, r in ipairs(k) do
					if r.id then
						D[r.id] = true;
					end;
				end;
			end;
		end;
		local h = 0;
		for C, r in ipairs(E.looks) do
			if type(r) == "table" and type(r.data_b64) == "string" then
				local C = r.id or ("look_" .. ((tostring(os.time()) .. (("_" .. tostring(math.random(100, 9999)))))));
				if not D[C] then
					local N = v(r.data_b64);
					if #N > 0 then
						local v = "facecard_" .. ((C .. ".dat"));
						writefile(v, N);
						table.insert(k, {
							id = C,
							name = r.name or "Restored Look",
							theme = r.theme or "General",
							author = r.author or "Unknown",
							file = v,
							created = r.created or os.date("%X"),
						});
						D[C] = true;
						h = h + 1;
					end;
				end;
			end;
		end;
		writefile(r, C:JSONEncode(k));
		t.Text = string.format("Berhasil! %d look restored", h);
		t.TextColor3 = Color3.fromRGB(100, 235, 145);
	end;
	local Q = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui") or ((game:GetService("Players"))).LocalPlayer:WaitForChild("PlayerGui");
	local o = Q:FindFirstChild("StealthXRestorePopup");
	if o then
		o:Destroy();
	end;
	local w = Instance.new("ScreenGui");
	w.Name = "StealthXRestorePopup";
	w.ResetOnSpawn = false;
	w.Parent = Q;
	local E = Instance.new("Frame");
	E.Size = UDim2.fromScale(1, 1);
	E.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	E.BackgroundTransparency = .45;
	E.Parent = w;
	local k = Instance.new("Frame");
	k.Size = UDim2.fromOffset(330, 195);
	k.Position = UDim2.fromScale(.5, .5);
	k.AnchorPoint = Vector2.new(.5, .5);
	k.BackgroundColor3 = Color3.fromRGB(22, 22, 24);
	k.BackgroundTransparency = .06;
	k.Parent = E;
	((Instance.new("UICorner", k))).CornerRadius = UDim.new(0, 16);
	local D = Instance.new("UIStroke", k);
	D.Color = Color3.fromRGB(255, 255, 255);
	D.Transparency = .85;
	local h = Instance.new("TextLabel", k);
	h.Size = UDim2.new(1, -32, 0, 24);
	h.Position = UDim2.fromOffset(16, 14);
	h.BackgroundTransparency = 1;
	h.Font = Enum.Font.GothamBold;
	h.Text = "Restore Look Library";
	h.TextColor3 = Color3.fromRGB(255, 255, 255);
	h.TextSize = 15;
	h.TextXAlignment = Enum.TextXAlignment.Left;
	local X = Instance.new("TextLabel", k);
	X.Size = UDim2.new(1, -32, 0, 18);
	X.Position = UDim2.fromOffset(16, 38);
	X.BackgroundTransparency = 1;
	X.Font = Enum.Font.Gotham;
	X.Text = "Tempel link file .json dari Discord:";
	X.TextColor3 = Color3.fromRGB(170, 170, 175);
	X.TextSize = 12;
	X.TextXAlignment = Enum.TextXAlignment.Left;
	local p = Instance.new("TextBox", k);
	p.Size = UDim2.new(1, -32, 0, 38);
	p.Position = UDim2.fromOffset(16, 64);
	p.BackgroundColor3 = Color3.fromRGB(14, 14, 16);
	p.Font = Enum.Font.Gotham;
	p.PlaceholderText = "https://cdn.discordapp.com/attachments/...";
	p.PlaceholderColor3 = Color3.fromRGB(100, 100, 105);
	p.Text = "";
	p.TextColor3 = Color3.fromRGB(245, 245, 245);
	p.TextSize = 12;
	p.TextXAlignment = Enum.TextXAlignment.Left;
	p.ClearTextOnFocus = false;
	p.ClipsDescendants = true;
	((Instance.new("UICorner", p))).CornerRadius = UDim.new(0, 10);
	local z = Instance.new("UIPadding", p);
	z.PaddingLeft = UDim.new(0, 12);
	z.PaddingRight = UDim.new(0, 12);
	local j = Instance.new("TextLabel", k);
	j.Size = UDim2.new(1, -32, 0, 18);
	j.Position = UDim2.fromOffset(16, 108);
	j.BackgroundTransparency = 1;
	j.Font = Enum.Font.Gotham;
	j.Text = "Siap memulihkan data ke workspace.";
	j.TextColor3 = Color3.fromRGB(140, 140, 145);
	j.TextSize = 11;
	j.TextXAlignment = Enum.TextXAlignment.Left;
	local m = Instance.new("TextButton", k);
	m.Size = UDim2.new(.5, -20, 0, 36);
	m.Position = UDim2.fromOffset(16, 142);
	m.BackgroundColor3 = Color3.fromRGB(38, 38, 42);
	m.Font = Enum.Font.GothamSemibold;
	m.Text = "Tutup";
	m.TextColor3 = Color3.fromRGB(220, 220, 225);
	m.TextSize = 13;
	((Instance.new("UICorner", m))).CornerRadius = UDim.new(0, 10);
	local f = Instance.new("TextButton", k);
	f.Size = UDim2.new(.5, -20, 0, 36);
	f.Position = UDim2.new(.5, 4, 0, 142);
	f.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	f.Font = Enum.Font.GothamBold;
	f.Text = "Restore";
	f.TextColor3 = Color3.fromRGB(15, 15, 18);
	f.TextSize = 13;
	((Instance.new("UICorner", f))).CornerRadius = UDim.new(0, 10);
	m.MouseButton1Click:Connect(function()
		w:Destroy();
	end);
	local g = false;
	f.MouseButton1Click:Connect(function()
		if g then
			return;
		end;
		local C = ((p.Text or "")):match("^%s*(.-)%s*$");
		if not C:match("^https?://") then
			j.Text = "add a valid JSON";
			j.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		g = true;
		f.Text = "Memproses...";
		task.spawn(function()
			t(C, j);
			f.Text = "Restore";
			g = false;
		end);
	end);
end;
