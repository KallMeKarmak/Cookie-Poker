SMODS.Atlas{
  key = 'j_lethalbite',
  path = 'j_lethalbite.png',
  px = 71,
  py = 95
}

SMODS.Joker{
  key = 'j_lethalbite',
  loc_txt = {
    name = 'Lethal Bite',
    text = {
      'Adds {C:mult}+#1#{} mult and',
      '{C:chips}+#2#{} chips every time',
      'a card is removed from your deck.',
      '{C:inactive}(Currently{} {C:mult}+#3#{}, {C:chips}+#4#{}{C:inactive}){}'
    },
  },
  atlas = 'j_lethalbite',
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = {x = 0, y = 0},
  config = {
    extra = {
      mult_scaler = 5,
      chips_scaler = 20,
      mult = 0,
      chips = 0
    }
  },
  loc_vars = function(self,info_queue,center)
    return {
      vars = {
        center.ability.extra.mult_scaler,
        center.ability.extra.chips_scaler,
        center.ability.extra.mult,
        center.ability.extra.chips,
      }
    }
  end,
  check_for_unlock = function(self, args)
    unlock_card(self)
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult,
        chips = card.ability.extra.chips
      }
    elseif context.remove_playing_cards then
      n_cards_removed = #context.removed
      card.ability.extra.chips = card.ability.extra.chips + n_cards_removed * card.ability.extra.chips_scaler
      card.ability.extra.mult = card.ability.extra.mult + n_cards_removed * card.ability.extra.mult_scaler
      return {
        message = 'Upgrade!',
        colour = G.C.RED
      }
    end
  end
}
