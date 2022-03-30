set_trace_log_level 5

require 'test/helpers'
require 'test/mtest_extensions'

require 'core/helpers'

require 'core/events'
require 'core/node'
require 'core/area'
require 'core/delay'
require 'core/scene'
require 'core/scene_manager'
require 'core/state_machine'

require 'extras/transitions/fade'
require 'extras/transitions/fade_in'
require 'extras/transitions/fade_out'

require 'test/helpers/test_scene'
require 'test/helpers/test_node'
require 'test/helpers/test_state_machine'

require 'test/core/events'
require 'test/core/node'
require 'test/core/area'
require 'test/core/delay'
require 'test/core/scene_manager'
require 'test/core/state_machine'

require 'test/extras/transitions/fade_in'
require 'test/extras/transitions/fade_out'

init_window(10, 10, 'beep')
exit 1 if MTest::Unit.new.run.positive?
close_window
