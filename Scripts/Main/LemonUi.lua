local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Baodzvip/edit/main/Scripts/Main/Fluent.lua"))()
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
    SelectWeapon = Window:AddTab({ Title = "Select Weapon", Icon = "citrus" }),
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
        Title = "Click",
        Description = "Click Sẽ Có Bất Ngờ!",
        Callback = function()
                game.Players.LocalPlayer:Kick("THẰNG NGU BỊ DỤ LÊU LÊU")
            end 
        })

    local Toggle = Tabs.Main:AddToggle("Toggle", {Title = "Dupe Op", Default = false })
    toggleButton.Changed:Connect(function()
         game.Players.LocalPlayer:Kick("ĐÃ DUPE THÀNH CÔNG!")
end)

    
    
    local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Speed",
        Description = "Speed test",
        Default = 2,
        Min = 0,
        Max = 100,
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
        Title = "Test",
        Values = {"one", "two", "three"},
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
        Values = {"one", "two", "three"},
        Multi = true,
        Default = {""},
    })

    MultiDropdown:SetValue({
        one = true,
        two = false,
        three = false
    })

    MultiDropdown:OnChanged(function(Value)
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        print("Mutlidropdown changed:", table.concat(Values, ", "))
    end)


    local Keybind = Tabs.Settings:AddKeybind("Keybind", {
        Title = "KeyBind",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "LeftControl", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            print("Keybind clicked!", Value)
        end,

        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
            print("Keybind changed!", New)
        end
    })

    -- OnClick is only fired when you press the keybind and the mode is Toggle
    -- Otherwise, you will have to use Keybind:GetState()
    Keybind:OnClick(function()
        print("Keybind clicked:", Keybind:GetState())
    end)

    Keybind:OnChanged(function()
        print("Keybind changed:", Keybind.Value)
    end)

    task.spawn(function()
        while true do
            wait(1)

            -- example for checking if a keybind is being pressed
            local state = Keybind:GetState()
            if state then
                print("Keybind is being held down")
            end

            if Fluent.Unloaded then break end
        end
    end)

    Keybind:SetValue("MB2", "Toggle") -- Sets keybind to MB2, mode to Hold


    local Input = Tabs.Settings:AddInput("Input", {
        Title = "Input",
        Default = "Default",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Input changed:", Value)
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.Value)
    end)
end




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

Tabs.AutoFarm:AddParagraph({
        Title = "Lemon Hub",
        Content = "Best Farm"
    })



Fluent:Notify({
    Title = "Lemon Hub",
    Content = "The script has been loaded.",
    Duration = 7
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
