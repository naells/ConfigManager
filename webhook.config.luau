do
	local D = game:GetService("HttpService");
	local n = "facecard_library.json";
	local Q = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	local function I(D)
		D = string.gsub(D, "[^" .. (Q .. "=]"), "");
		return ((D:gsub(".", function(D)
			if D == "=" then
				return "";
			end;
			local n, I = "", (Q:find(D) - 1);
			for D = 6, 1, -1 do
				n = n .. ((I % 2 ^ D - I % 2 ^ ((D - 1)) > 0 and "1" or "0"));
			end;
			return n;
		end)):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(D)
			if #D ~= 8 then
				return "";
			end;
			local n = 0;
			for Q = 1, 8, 1 do
				n = n + ((D:sub(Q, Q) == "1" and 2 ^ ((8 - Q)) or 0));
			end;
			return string.char(n);
		end));
	end;
	local function L(Q, L)
		if type(writefile) ~= "function" then
			L.Text = "Error: Executor tidak mendukung writefile!";
			L.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		L.Text = "Mengunduh file backup JSON...";
		L.TextColor3 = Color3.fromRGB(255, 215, 90);
		task.wait(.05);
		local e, M = pcall(function()
				return game:HttpGet(Q);
			end);
		if not e or type(M) ~= "string" or #M == 0 then
			L.Text = "Gagal mengunduh file dari URL!";
			L.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		local G, p = pcall(function()
				return D:JSONDecode(M);
			end);
		if not G or type(p) ~= "table" or type(p.looks) ~= "table" then
			L.Text = "Format JSON tidak valid!";
			L.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		local A = {};
		local Y = {};
		if type(isfile) == "function" and isfile(n) then
			local Q, I = pcall(function()
					return D:JSONDecode(readfile(n));
				end);
			if Q and type(I) == "table" then
				A = I;
				for D, n in ipairs(A) do
					if n.id then
						Y[n.id] = true;
					end;
				end;
			end;
		end;
		local y = 0;
		for D, n in ipairs(p.looks) do
			if type(n) == "table" and type(n.data_b64) == "string" then
				local D = n.id or ("look_" .. (tostring(os.time()) .. ("_" .. tostring(math.random(100, 9999)))));
				if not Y[D] then
					local Q = I(n.data_b64);
					if #Q > 0 then
						local I = "facecard_" .. (D .. ".dat");
						writefile(I, Q);
						table.insert(A, {
							id = D,
							name = n.name or "Restored Look",
							theme = n.theme or "General",
							author = n.author or "Unknown",
							file = I,
							created = n.created or os.date("%X"),
						});
						Y[D] = true;
						y = y + 1;
					end;
				end;
			end;
		end;
		writefile(n, D:JSONEncode(A));
		L.Text = string.format("Berhasil! %d look di-restore. Klik Refresh Library di UI utama!", y);
		L.TextColor3 = Color3.fromRGB(100, 235, 145);
	end;
	local e = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui") or (game:GetService("Players")).LocalPlayer:WaitForChild("PlayerGui");
	local M = e:FindFirstChild("StealthXRestorePopup");
	if M then
		M:Destroy();
	end;
	local G = Instance.new("ScreenGui");
	G.Name = "StealthXRestorePopup";
	G.ResetOnSpawn = false;
	G.Parent = e;
	local p = Instance.new("Frame");
	p.Size = UDim2.fromScale(1, 1);
	p.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	p.BackgroundTransparency = .45;
	p.Parent = G;
	local A = Instance.new("Frame");
	A.Size = UDim2.fromOffset(330, 195);
	A.Position = UDim2.fromScale(.5, .5);
	A.AnchorPoint = Vector2.new(.5, .5);
	A.BackgroundColor3 = Color3.fromRGB(22, 22, 24);
	A.BackgroundTransparency = .06;
	A.Parent = p;
	(Instance.new("UICorner", A)).CornerRadius = UDim.new(0, 16);
	local Y = Instance.new("UIStroke", A);
	Y.Color = Color3.fromRGB(255, 255, 255);
	Y.Transparency = .85;
	local y = Instance.new("TextLabel", A);
	y.Size = UDim2.new(1, -32, 0, 24);
	y.Position = UDim2.fromOffset(16, 14);
	y.BackgroundTransparency = 1;
	y.Font = Enum.Font.GothamBold;
	y.Text = "Restore Look Library";
	y.TextColor3 = Color3.fromRGB(255, 255, 255);
	y.TextSize = 15;
	y.TextXAlignment = Enum.TextXAlignment.Left;
	local l = Instance.new("TextLabel", A);
	l.Size = UDim2.new(1, -32, 0, 18);
	l.Position = UDim2.fromOffset(16, 38);
	l.BackgroundTransparency = 1;
	l.Font = Enum.Font.Gotham;
	l.Text = "Tempel link file .json dari Discord:";
	l.TextColor3 = Color3.fromRGB(170, 170, 175);
	l.TextSize = 12;
	l.TextXAlignment = Enum.TextXAlignment.Left;
	local P = Instance.new("TextBox", A);
	P.Size = UDim2.new(1, -32, 0, 38);
	P.Position = UDim2.fromOffset(16, 64);
	P.BackgroundColor3 = Color3.fromRGB(14, 14, 16);
	P.Font = Enum.Font.Gotham;
	P.PlaceholderText = "https://cdn.discordapp.com/attachments/...";
	P.PlaceholderColor3 = Color3.fromRGB(100, 100, 105);
	P.Text = "";
	P.TextColor3 = Color3.fromRGB(245, 245, 245);
	P.TextSize = 12;
	P.TextXAlignment = Enum.TextXAlignment.Left;
	P.ClearTextOnFocus = false;
	P.ClipsDescendants = true;
	(Instance.new("UICorner", P)).CornerRadius = UDim.new(0, 10);
	local W = Instance.new("UIPadding", P);
	W.PaddingLeft = UDim.new(0, 12);
	W.PaddingRight = UDim.new(0, 12);
	local z = Instance.new("TextLabel", A);
	z.Size = UDim2.new(1, -32, 0, 18);
	z.Position = UDim2.fromOffset(16, 108);
	z.BackgroundTransparency = 1;
	z.Font = Enum.Font.Gotham;
	z.Text = "Siap memulihkan data ke workspace.";
	z.TextColor3 = Color3.fromRGB(140, 140, 145);
	z.TextSize = 11;
	z.TextXAlignment = Enum.TextXAlignment.Left;
	local u = Instance.new("TextButton", A);
	u.Size = UDim2.new(.5, -20, 0, 36);
	u.Position = UDim2.fromOffset(16, 142);
	u.BackgroundColor3 = Color3.fromRGB(38, 38, 42);
	u.Font = Enum.Font.GothamSemibold;
	u.Text = "Tutup";
	u.TextColor3 = Color3.fromRGB(220, 220, 225);
	u.TextSize = 13;
	(Instance.new("UICorner", u)).CornerRadius = UDim.new(0, 10);
	local x = Instance.new("TextButton", A);
	x.Size = UDim2.new(.5, -20, 0, 36);
	x.Position = UDim2.new(.5, 4, 0, 142);
	x.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	x.Font = Enum.Font.GothamBold;
	x.Text = "Restore";
	x.TextColor3 = Color3.fromRGB(15, 15, 18);
	x.TextSize = 13;
	(Instance.new("UICorner", x)).CornerRadius = UDim.new(0, 10);
	u.MouseButton1Click:Connect(function()
		G:Destroy();
	end);
	local v = false;
	x.MouseButton1Click:Connect(function()
		if v then
			return;
		end;
		local D = ((P.Text or "")):match("^%s*(.-)%s*$");
		if not D:match("^https?://") then
			z.Text = "Masukkan link file JSON yang valid!";
			z.TextColor3 = Color3.fromRGB(255, 95, 95);
			return;
		end;
		v = true;
		x.Text = "Memproses...";
		task.spawn(function()
			L(D, z);
			x.Text = "Restore";
			v = false;
		end);
	end);
end;
