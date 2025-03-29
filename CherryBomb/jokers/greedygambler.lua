SMODS.Atlas{
    key = 'j_greedygambler',
    path = 'j_greedygambler.png',
    px = 71,
    py = 95
  }
  
  SMODS.Joker{
    key = 'j_greedygambler',
    loc_txt = {
      name = 'Greedy Gambler',
      text = {
        'Gives {C:money}$#1#{} at end of round',
        '{C:green}#2# in #3#{} chance to',
        'set money to {C:money}$0{}.'
      },
    },
    atlas = 'j_greedygambler',
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
        money_gain = 20,
        odds = 5,
      }
    },
    loc_vars = function(self,info_queue,center)
      return {
        vars = {
          center.ability.extra.money_gain,
          G.GAME.probabilities.normal,
          center.ability.extra.odds,
        }
      }
    end,
    check_for_unlock = function(self, args)
      unlock_card(self)
    end,
    calculate = function(self, card, context)
      if context.end_of_round and context.cardarea == G.jokers then
        local rolled_value = pseudorandom("j_greedygambler")
        local odds_ratio = G.GAME.probabilities.normal / card.ability.extra.odds
        local set_money_zero = rolled_value < odds_ratio
        if set_money_zero then
             return {
                dollars = -G.GAME.dollars
             }
        else
            return {
                dollars = card.ability.extra.money_gain
            }
        end
      end
    end
  }
  