local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baodzvip/edit/main/Scripts/Main/Main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baodzvip/edit/main/Scripts/Main/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baodzvip/edit/main/Scripts/Main/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Lemon Hub " ,
    SubTitle = "by baodzvip",
    TabWidth = 150,
    Size = UDim2.fromOffset(500, 320),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "airplay" }),
    AutoFarm = Window:AddTab({ Title = "Farm", Icon = "citrus" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "Lemon Hub",
        SubContent = "By baodzvip", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })



    Tabs.Main:AddParagraph({
        Title = "Lemon Hub",
        Content = "Best Script"
    })



    Tabs.Main:AddButton({
        Title = "Fly",
        Description = "You Want Fly?",
        Callback = function()
            Window:Dialog({
                Title = "Fly",
                Content = "Yes or No?",
                Buttons = {
                    {
                        Title = "Yes",
                        Callback = function()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/Baodzvip/Free/main/Scripts/LemonHub.lua"))()
                        end
                    },
                    {
                        Title = "No",
                        Callback = function()
                            print("No Fly")
                        end
                    }
                }
            })
        end
    })


    Tabs.Main:AddButton({
        Title = "AUTO RAID",
        Description = "AUTO RAID 100% RIEL NO FAKE",
        Callback = function()
                game.Players.LocalPlayer:Kick("Hãy thử lại 🤡")
            end 
        })

            
    local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Toggle", Default = false })

    Toggle:OnChanged(function()
        print("Toggle changed:", Options.MyToggle.Value)
    end)

    Options.MyToggle:SetValue(false)


    
    local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Slider",
        Description = "This is a slider",
        Default = 2,
        Min = 0,
        Max = 5,
        Rounding = 1,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })

    Slider:OnChanged(function(Value)
        print("Slider changed:", Value)
    end)

    Slider:SetValue(3)



    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Dropdown",
        Values = {"one", "two"},
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("one")

    Dropdown:OnChanged(function(Value)
        print("Dropdown changed:", Value)
    end)


    
    local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
        Title = "Dropdown",
        Description = "You can select multiple values.",
        Values = {"one", "two"},
        Multi = true,
        Default = {"one"},
    })

    MultiDropdown:SetValue({
        three = true,
        five = true,
        seven = false
    })

    MultiDropdown:OnChanged(function(Value)
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        print("Mutlidropdown changed:", table.concat(Values, ", "))
    end)



    local Weaponlist = {}
    local Weapon = nil

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
end

spawn(function()
while wait() do
if AutoEquiped then
pcall(function()
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Weapon))
                        end)
                end
            end
        end)


 Tabs.Main = Tabs.Main:AddDropdown({
	Title = "Select Weapon",
	Default = nil,
	Options = Weaponlist,
	Callback = function(Value)
		Weapon = Value
	end    
})

    Tabs.Main:AddButton({
    Title = "Refresh Weapon",
    Callback = function()
    Wapon = {}
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
    if v:IsA("Tool") then
       table.insert(Wapon ,v.Name)
    end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
    if v:IsA("Tool") then
       table.insert(Wapon, v.Name)
    end
end
              Weapon_Tab:Refresh(Wapon,true)
      end    
})


Tabs.Main:AddToggle({
	title = "AutoEquiped",
	Default = nil,
	Callback = function(Value)
		AutoEquiped = Value
	end    
})
    
-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("LemonHub")
SaveManager:SetFolder("LemonHub/Games")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Lemon Hub",
    Content = "The script has been loaded.",
    Duration = 7
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
