--- STEAMODDED HEADER
--- MOD_NAME: CherryBomb
--- MOD_ID: CherryBomb
--- MOD_AUTHOR: [As9ect]
--- MOD_DESCRIPTION: Cherrybomb
--- PREFIX: WWW
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'CherryBomb', --joker key
    loc_txt = { -- local text
        name = 'Cherry Bomb',
        text = {
          '1 in 4 chance to',
          'self destruct and give',
          '{X:mult,C:white}X#1#{}mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = {
      extra = {
        Xmult = 10,
        odds= 4 --configurable value
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'Cherrybomb' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.final_scoring_step then
            if (pseudorandom("j_cherrybomb") < G.GAME.probabilities.normal / card.ability.extra.odds) then
              G.E_MANAGER:add_event(Event({
                func = function()
                  play_sound('tarot1')
                  card.T.r = -0.2
                  card:juice_up(0.3, 0.4)
                  card.states.drag.is = true
                  card.children.center.pinch.x = true
                  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                      G.jokers:remove_card(card)
                      card:remove()
                      card = nil
                      return true; 
                    end
                  })) 
                  return true
                end
              })) 
              return {
                xmult = card.ability.extra.Xmult
              }
            else
              return {}
            end
          end
    end
}

----------------------------------------------
------------MOD CODE END----------------------