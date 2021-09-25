class TestEngineEvents < MTest::Unit::TestCase
  def test_initialize
    assert_equal({}, Events.new.events)
  end

  def test_add_listener
    event_fired = false
    events = Events.new
    events.add_listener(event: 'test', id: 1) { event_fired = true }

    assert_kind_of Proc, events.events['test'][1][0]
    assert_equal false, events.events['test'][1][1]
    assert_false event_fired
  end

  def test_add_listener_no_id
    event_fired = false
    events = Events.new
    assert_raise(ArgumentError) {
      events.add_listener(event: 'test') { event_fired = true }
    }
  end

  def test_add_listener_no_event
    event_fired = false
    events = Events.new
    assert_raise(ArgumentError) {
      events.add_listener(id: 1) { event_fired = true }
    }
  end

  def test_remove_listener
    event_fired = false
    events = Events.new
    events.add_listener(event: 'test', id: 1) { event_fired = true }

    assert_kind_of Proc, events.events['test'][1][0]
    assert_equal false, events.events['test'][1][1]
    assert_false event_fired

    events.remove_listener(event: 'test', id: 1)

    assert_nil events.events['test'][1]
  end

  def test_trigger
    event_fired = false
    other_event_fired = false
    events = Events.new
    events.add_listener(event: 'test', id: 1) { event_fired = true }
    events.add_listener(event: 'other', id: 1) { other_event_fired = true }

    assert_kind_of Proc, events.events['test'][1][0]
    assert_equal false, events.events['test'][1][1]
    assert_false event_fired
    assert_kind_of Proc, events.events['other'][1][0]
    assert_equal false, events.events['other'][1][1]
    assert_false other_event_fired

    events.trigger('test')
    assert_kind_of Proc, events.events['test'][1][0]
    assert_equal false, events.events['test'][1][1]
    assert_true event_fired
    assert_kind_of Proc, events.events['other'][1][0]
    assert_equal false, events.events['other'][1][1]
    assert_false other_event_fired
  end

  def test_trigger_once
    event_fired = false
    other_event_fired = false
    events = Events.new
    events.add_listener(event: 'test', id: 1, once: true) { event_fired = true }
    events.add_listener(event: 'other', id: 1, once: true) { other_event_fired = true }

    assert_kind_of Proc, events.events['test'][1][0]
    assert_equal true, events.events['test'][1][1]
    assert_false event_fired
    assert_kind_of Proc, events.events['other'][1][0]
    assert_equal true, events.events['other'][1][1]
    assert_false other_event_fired

    events.trigger('test')
    assert_nil events.events['test'][1]
    assert_true event_fired
    assert_kind_of Proc, events.events['other'][1][0]
    assert_equal true, events.events['other'][1][1]
    assert_false other_event_fired
  end
end
