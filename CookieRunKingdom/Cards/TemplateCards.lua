--- STEAMODDED HEADER
--- MOD_NAME: Cookie Run Cards
--- MOD_ID: TemplateCards
--- MOD_AUTHOR: [KallMeKarmak/Karkat]
--- MOD_DESCRIPTION: This is a mod for CRK fans! It replaces all the playing cards with Cookie Run characters

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.DecColors()

    local dec_mod = SMODS.findModByID("TemplateCards")
    local sprite_card = SMODS.Sprite:new("cards_1", dec_mod.path, "TemplateCards.png", 71, 95, "asset_atli")
    
    sprite_card:register()
end

----------------------------------------------
------------MOD CODE END----------------------
