require "/scripts/util.lua"
require "/scripts/vec2.lua"

function init()

  self.controlMovement = config.getParameter("controlMovement")
  self.timedActions = config.getParameter("timedActions", {})
  self.aimPosition = mcontroller.position()

  message.setHandler("updateProjectile", function(_, _, aimPosition)
      self.aimPosition = aimPosition
      return entity.id()
    end)

  message.setHandler("::break", function()
      projectile.die()
    end)

end

function update(dt)

  if self.aimPosition then
    if self.controlMovement then
      controlTo(self.aimPosition)
    end
  end

end