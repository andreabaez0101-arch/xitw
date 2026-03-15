Config = {}

-- We also recommend vms_charcreator, it fits perfectly with the style!

--====================================================--
-- For more information, read the documentation
-- https://docs.vames-store.com/assets/vms_clothestore
--====================================================--


Config.Core = "QB-Core" -- "ESX" / "QB-Core"
Config.CoreExport = function()
    if Config.Core == "ESX" then
        return exports['es_extended']:getSharedObject() -- ESX
    else
        return exports['qb-core']:GetCoreObject() -- QB-CORE
    end
end

Config.Notification = function(message, time, type)
    if type == "success" then
        if GetResourceState('vms_notify') ~= 'missing' then
            exports["vms_notify"]:Notification("CLOTHES STORE", message, time, "#27FF09", "fa-solid fa-shirt")
        else
            -- TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "error" then
        if GetResourceState('vms_notify') ~= 'missing' then
            exports["vms_notify"]:Notification("CLOTHES STORE", message, time, "#FF0909", "fa-solid fa-shirt")
        else
            -- TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    end
end

Config.Hud = {
    Enable = function()
        if GetResourceState('xrv2-hud') ~= 'missing' then
            exports["xrv2-hud"]:setDisplay(true)
            -- DisplayRadar(true)
        end
    end,
    Disable = function()
        if GetResourceState('xrv2-hud') ~= 'missing' then
            -- exports['xrespect-hud']:Display(false)
            exports["xrv2-hud"]:setDisplay(false)
            -- DisplayRadar(false)
        end
    end
}

Config.Interact = {
    Enabled = true,
    Open = function()
        exports["interact"]:Open("E", Config.Translate['press_to_open']) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['okokTextUI']:Open('[E] '..Config.Translate['press_to_open'], 'darkgreen', 'right')
        -- exports['jg-textui']:DrawText('[E] Presiona para abrir tienda de ropa')
        -- exports['xrv2-textui']:showPersist("Abrir tienda de ropa", "E")
        -- exports['qb-core']:DrawText(Config.Translate['press_to_open'], 'right')
    end,
    Close = function()
        exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['okokTextUI']:Close()
        -- exports['qb-core']:HideText()
        -- exports['jg-textui']:HideText()
        -- exports['xrv2-textui']:hidePersist()
    end
}

-- @UseTarget: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target'
Config.Target = function(data, cb)
    if Config.TargetResource == 'ox_target' then
        return exports[Config.TargetResource]:addBoxZone({
            coords = vec(data.coords.x, data.coords.y, data.coords.z),
            size = vec(data.targetSize.x, data.targetSize.y, data.targetSize.z),
            debug = false,
            useZ = true,
            rotation = data.targetRotation,
            options = {
                {
                    distance = 2.0,
                    name = 'clothestore',
                    icon = "fa-solid fa-shirt",
                    label = Config.Translate["target.clothestore"],
                    onSelect = function()
                        cb()
                    end
                }
            }
        })
    else
        print('You need to prepare Config.Target for the target system')
    end
end

Config.GetClosestPlayersFunction = function()
    local playerInArea = Config.Core == "ESX" and ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 10.0) or QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)
    return playerInArea
end

Config.UseCustomQuestionMenu = false -- if you want to use for example vms_notify Question Menu, set it true, if you want to use default menu from Config.Menu set it false
Config.CustomQuestionMenu = function(requesterId, outfitName, outfitTable)
    local question = exports['vms_notify']:Question(
        Config.Translate["share_outfit_title"], 
        Config.PriceForAcceptOutfit and Config.PriceForAcceptOutfit >= 1 and (Config.Translate['share_outfit_description']):format(outfitName, Config.PriceForAcceptOutfit) or (Config.Translate['share_outfit_description_free']):format(outfitName),
        '#8cfa64', 
        'fa-solid fa-shirt'
    )
    Citizen.Await(question)
    if question == 'y' then -- vms_notify question export return 'y' when player accept and 'n' when player reject
        TriggerServerEvent("vms_clothestore:acceptOutfit", requesterId, outfitName, outfitTable)
    end
end

-- @KeyOpen - https://docs.fivem.net/docs/game-references/controls/
Config.KeyOpen = 38 -- [E]

-- @SkinManager - ESX: "esx_skin" / "fivem-appearance" / "illenium-appearance"
-- @SkinManager - QB-Core: "qb-clothing" / "fivem-appearance" / "illenium-appearance"
Config.SkinManager = "illenium-appearance"


-- @UseQSInventory - if you use qs-inventory and clothing options
Config.UseQSInventory = false
Config.QSInventoryName = 'qs-inventory'

-- @ChangeClothes - Menu for choosing whether to buy new clothes or change into your clothes
Config.ChangeClothes = true

Config.DataStoreName = "property"

-- @ShareOutfit - Gives the ability to share a saved outfit with another player
Config.ShareOutfit = true

-- @PriceForAcceptOutfit - The price at which a player can accept an outfit
Config.PriceForAcceptOutfit = 100

Config.ManageClothes = true

-- @SaveClothesMenu - Clothes saving
Config.SaveClothesMenu = true

-- @Menu for ESX: "esx_context", "esx_menu_default", "ox_lib"
-- @Menu for QB-Core: "qb-menu", "ox_lib"
Config.Menu = "ox_lib"
Config.ESXMenuDefault_Align = 'right' -- works only for esx_menu_default
Config.ESXContext_Align = 'right' -- works only for ESX_Context


Config.SoundsEffects = true -- if you want to sound effects by clicks set true
Config.BlurBehindPlayer = false -- to see it you need to have PostFX upper Very High or Ultra

Config.EnableHandsUpButtonUI = true -- Is there to be a button to raise hands on the UI
Config.HandsUpKey = 'x' -- Key JS (key.code) - https://www.toptal.com/developers/keycode
Config.HandsUpAnimation = {'missminuteman_1ig_2', 'handsup_enter', 50}

Config.ClothingPedAnimation = {"missclothing", "idle_storeclerk"} -- animation of the player during character creation

Config.DefaultCamDistance = 0.95 -- camera distance from player location (during character creation)
Config.CameraHeight = {
    ['masks'] = {z_height = 0.65, fov = 25.0},
    ['hats'] = {z_height = 0.65, fov = 25.0},
    ['torsos'] = {z_height = 0.175, fov = 68.0},
    ['bproofs'] = {z_height = 0.175, fov = 68.0},
    ['pants'] = {z_height = -0.425, fov = 75.0},
    ['shoes'] = {z_height = -0.75, fov = 75.0},
    ['chains'] = {z_height = 0.35, fov = 35.0},
    ['glasses'] = {z_height = 0.65, fov = 25.0},
    ['watches'] = {z_height = -0.025, fov = 45.0},
    ['ears'] = {z_height = 0.65, fov = 30.0},
    ['bags'] = {z_height = 0.15, fov = 75.0},
}

Config.CameraSettings = {
    startingFov = 25.0,
    maxCameraFov = 120.0,
    minCameraFov = 10.0,
    maxCameraHeight = 2.5,
    minCameraHeight = -0.85
}

Config.Translate = {
    ['share_outfit_to_player'] = {name = 'Compartir outfit - %s', icon = ''},
    ['share_outfit_to_player_id'] = 'Jugador [%s]',
    ['share_outfit_title'] = 'Compartir Outfit',
    ['share_outfit_description_free'] = 'Quieres aceptar el estilo del outfit? - %s',
    ['share_outfit_description'] = 'Quieres comprar el outfit - %s por $%s',
    ['received_outfit'] = 'Recibiste estilo de atuendo - %s',
    ['sent_outfit'] = 'Usted envió el estilo de atuendo - %s',
    ['no_players_around'] = 'No hay jugadores a tu alrededor',

    ['title_share_free'] = {name = 'Quieres aceptar este outfit %s?', icon = 'fas fa-shirt'},
    ['title_share'] = {name = 'Quieres comprar el outfit %s por $%s?', icon = 'fas fa-shirt'},
    ['share_accept'] = {name = 'Si', icon = 'fas fa-check'},
    ['share_reject'] = {name = 'No', icon = 'fas fa-xmark'},


    ['blip.clothesstore'] = 'Tienda de Ropa',
    ['blip.maskstore'] = 'Tienda Mascaras',
    
    ['target.clothestore'] = 'Tienda de Ropa',
    ['press_to_open'] = 'Presiona para abrir',

    ['you_paid'] = 'Has pagado %s$ por las prendas',
    ['saved_clothes'] = 'Has guardado tu conjunto con el nombre %s',
    ['removed_clothes'] = 'Tus prendas se han eliminado del guardaropa.',
    ['enought_money'] = 'No tienes el dinero suficiente',
    
    ['name_is_too_short'] = 'El nombre de la ropa es muy corto',

    ['select_option'] = {name = 'Seleccionar opcion', icon = 'fas fa-check-double'},
    ['manage_header'] = {name = 'Administrar Ropas', icon = 'fas fa-tshirt'}, 
    ['share_header'] = {name = 'Compartir outfit', icon = 'fas fa-share'}, 
    ['wardrobe_header'] = {name = 'Guardaropa', icon = 'fas fa-tshirt'}, 

    ['open_wardrobe'] = {name = 'Abrir Guardaropa', icon = 'fas fa-shirt'},
    ['open_manage'] = {name = 'Administrar Prendas', icon = 'fas fa-shirt'},
    ['open_share'] = {name = 'Compartir Prendas', icon = 'fas fa-share'},
    ['open_store'] = {name = 'Abrir tienda', icon = 'fas fa-bag-shopping'},
    
    ['menu:header'] = {name = 'Quieres guardar este outfit?', icon = 'fas fa-check-double'},
    ['menu:yes'] = {name = 'Si', icon = 'fas fa-check-circle'},
    ['menu:no'] = {name = 'No', icon = 'fas fa-window-close'},
    
    ['title_remove'] = {name = 'Quieres eliminarlo %s?', icon = 'fas fa-shirt'},
    ['remove_yes'] = {name = 'Si', icon = 'fas fa-check'},
    ['remove_no'] = {name = 'No', icon = 'fas fa-xmark'},

    ['esx_menu_default:header'] = 'Nombra tu outfit',
    ['esx_context:title'] = {name = 'Ingres nombre de tu outfit', icon = 'fas fa-shirt'},
    ['esx_context:placeholder_title'] = 'Nombre de Outfit',
    ['esx_context:placeholder'] = 'Nombre del outfit en guardaropa..',
    ['esx_context:confirm'] = {name = 'Confirmar', icon = 'fas fa-check-circle'},

    ['qb-input:header'] = 'Nombra tu outfit',
    ['qb-input:submitText'] = 'Guardar Outfit',
    ['qb-input:text'] = 'Nombre Outfit',
}

Config.Stores = {
    [2] = {
        coords = vector3(-163.19, -310.78, 39.83),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = nil,
            size = vec(3.0, 3.0, 2.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = false,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [3] = {
        coords = vector3(75.7095, -1396.4718, 29.6736),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(3.0, 3.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [4] = {
        coords = vector3(425.4483, -802.5006, 29.7886),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(3.0, 3.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [5] = {
        coords = vector3(120.3456, -221.5374, 54.5576),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(3.0, 3.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [6] = {
        coords = vector3(-716.01, -147.9, 36.42),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [7] = {
        coords = vector3(-1189.4296, -772.1358, 17.3285),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [8] = {
        coords = vector3(-3176.0063, 1045.5848, 20.8630),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [9] = {
        coords = vector3(619.7296, 2763.7878, 42.0879),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [10] = {
        coords = vector3(-1104.0510, 2707.7969, 19.4053),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [11] = {
        coords = vector3(1192.9485, 2709.9602, 38.5201),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [12] = {
        coords = vector3(1693.0720, 4826.6602, 42.3606),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [13] = {
        coords = vector3(7.2403, 6515.2520, 32.1753),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {2, 3, 4},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [14] = {
        coords = vector3(-826.0060, -1075.6083, 11.6256),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {2, 3, 4},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [15] = {
        coords = vector3(-1447.2612, -229.9992, 49.8053),
        targetRotation = 85.0,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {2, 3, 4},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [16] = {
        coords = vector3(824.38, -283.83, 66.28),
        targetRotation = 81.5,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
    [17] = {
        coords = vector3(-1330.11, -208.19, 32.49),
        targetRotation = 228.28,
        targetSize = vec(2.15, 2.15, 2.15),
        blip = {
            sprite = Config.CSBlipSprite,
            display = 4,
            scale = 0.6,
            color = Config.CSBLipColor,
            name = Config.Translate['blip.clothesstore'],
        },
        marker = {
            id = 21,
            size = vec(5.0, 5.0, 5.0),
            color = {255, 255, 255, 0},
            rotate = false,
            bobUpAndDown = false
        },
        categories = {
            ['masks'] = true,
            ['hats'] = true,
            ['torsos'] = true,
            ['bproofs'] = true,
            ['pants'] = true,
            ['shoes'] = true,
            ['chains'] = true,
            ['glasses'] = true,
            ['watches'] = true,
            ['ears'] = true,
            ['bags'] = true,
        },
        blockedClothes = {
            ['male'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
            ['female'] = {
                -- ['helmet_1'] = {46, 100000},
                -- ['mask_1'] = {},
                -- ['tshirt_1'] = {10, 15, 16, 17, 18, 19, 20},
                -- ['torso_1'] = {},
                -- ['arms'] = {},
                -- ['decals_1'] = {},
                -- ['bproof_1'] = {},
                -- ['pants_1'] = {},
                -- ['shoes_1'] = {},
                -- ['chain_1'] = {},
                -- ['glasses_1'] = {},
                -- ['watches_1'] = {},
                -- ['bracelets_1'] = {},
                -- ['ears_1'] = {},
                -- ['bags_1'] = {},
            },
        }
    },
}