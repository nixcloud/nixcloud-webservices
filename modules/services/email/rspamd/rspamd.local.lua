local rspamd_logger = require "rspamd_logger"

rspamd_config.UPSTREAM_SCORE = {
  callback = function(task)
    local xss = task:get_header('X-Spam-Status')
    if xss then
      rspamd_logger.debugx(rspamd_config, 'Got upstream header %s', xss)
      local score = string.gsub(xss, "^.*%sscore=(%-?%d+%.%d+)$", "%1")
      rspamd_logger.debugx(rspamd_config, 'Got upstream score %s', score)
      return tonumber(score)
    else
      rspamd_logger.debugx(rspamd_config, 'Found no upstream header')
      return 0.0
    end
  end,
  score = 1,
  description = 'Score from milter scan',
  group = "upstream",
}
rspamd_logger.debugx(rspamd_config, 'Work dammit!!!')
