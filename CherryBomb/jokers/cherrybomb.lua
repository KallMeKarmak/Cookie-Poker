SMODS.Atlas{
  key = 'j_cherrybomb',
  path = 'j_cherrybomb.png',
  px = 71,
  py = 95
}

SMODS.Joker{
  key = 'j_cherrybomb',
  loc_txt = {
    name = 'Cherry Bomb',
    text = {
      '{C:green}#1# in #2#{} chance to',
      'self destruct and give',
      '{X:mult,C:white}X#3#{} mult'
    },
  },
  atlas = 'j_cherrybomb',
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
      Xmult = 10,
      odds = 4,
      active = false
    }
  },
  loc_vars = function(self,info_queue,center)
    return {
      vars = {
        G.GAME.probabilities.normal,
        center.ability.extra.odds, 
        center.ability.extra.Xmult
      }
    }
  end,
  check_for_unlock = function(self, args)
    unlock_card(self)
  end,
  calculate = function(self,card,context)
    if context.joker_main then
      -- cherrybomb has popped
      rolled_value = pseudorandom("j_cherrybomb")
      odds_ratio = G.GAME.probabilities.normal / card.ability.extra.odds
      card.ability.extra.active = (rolled_value < odds_ratio)
      if card.ability.extra.active then
        return {
          xmult = card.ability.extra.Xmult
        }
      else -- cherrybomb has not popped
        return {}
      end
    elseif context.after then
      -- scoring has completed and cherrybomb just popped, destroy the card.
      if card.ability.extra.active then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({
              trigger = 'after', 
              delay = 0.3, 
              blockable = false,
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
        card.ability.extra.active = false
      end
    end
  end
}
