set_trace_log_level 5

require 'core/helpers'

require 'core/events'
require 'core/node'
require 'core/area'
require 'core/delay'
require 'core/scene'
require 'core/scene_manager'

require 'extras/transitions/fade'
require 'extras/transitions/fade_in'
require 'extras/transitions/fade_out'

require 'test/helpers/test_scene'
require 'test/helpers/test_node'

require 'test/core/events'
require 'test/core/node'
require 'test/core/area'
require 'test/core/delay'
require 'test/core/scene_manager'

require 'test/extras/transitions/fade_in'
require 'test/extras/transitions/fade_out'

exit 1 if MTest::Unit.new.run.positive?