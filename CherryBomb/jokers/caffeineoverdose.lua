SMODS.Atlas{
  key = 'j_caffeineoverdose',
  path = 'j_caffeineoverdose.png',
  px = 71,
  py = 95
}

SMODS.Joker{
  key = 'j_caffeineoverdose',
  loc_txt = {
    name = 'Caffeine Overdose',
    text = {
      'Gives {X:mult,C:white}X#2#{} mult when filled.',
      'Loses {X:mult,C:white}X1{} mult per hand played.',
      'Refills when a {C:spades}Spades{} Flush is played.',
      '{C:inactive}(Currently{} {X:mult,C:white}X#1#{}{C:inactive}){}'
    },
  },
  atlas = 'j_caffeineoverdose',
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
      Xmult = 1,
      Xmult_max = 5,
      active = false,
    }
  },
  loc_vars = function(self,info_queue,center)
    return {
      vars = {
        center.ability.extra.Xmult,
        center.ability.extra.Xmult_max
      }
    }
  end,
  check_for_unlock = function(self, args)
    unlock_card(self)
  end,
  calculate = function(self,card,context)
    if context.before then
      sendTraceMessage("[context.before] we are in context.before", "CaffeineOverdoseLogger")
      if next(context.poker_hands['Flush']) and context.full_hand[1]:is_suit("Spades") then
        sendTraceMessage("[context.before] we have played a spades flush", "CaffeineOverdoseLogger")
        -- refill the mug
        card.ability.extra.Xmult = card.ability.extra.Xmult_max
        return {
          message = 'Refilled!',
          colour = G.C.RED
        }
      end
    elseif context.joker_main then
      return {
        xmult = card.ability.extra.Xmult
      }
    elseif context.after then
      card.ability.extra.Xmult = math.max(1, card.ability.extra.Xmult - 1)
      if card.ability.extra.Xmult > 1 then
        return {
          message = '-X1',
          colour = G.C.RED
        }
      end
    end
  end
}
