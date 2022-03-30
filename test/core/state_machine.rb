class TestEngineStateMachine < MTest::Unit::TestCase
  def test_initialize
    machine = TestStateMachine.new
    assert_instance_of TestStateMachine, machine
    assert_instance_of TestStateMachine::State::Alive, machine.state
  end

  def test_transition_to
    machine = TestStateMachine.new
    assert_instance_of TestStateMachine::State::Alive, machine.state
    machine.transition_to :dead
    assert_instance_of TestStateMachine::State::Dead, machine.state
  end

  def test_transition_to_invalid_state
    machine = TestStateMachine.new
    assert_raise(ArgumentError) { machine.transition_to :quirky }
  end

  def test_generated_state_check_methods
    machine = TestStateMachine.new
    assert_true machine.alive?
    assert_false machine.dead?
    machine.transition_to :dead
    assert_false machine.alive?
    assert_true machine.dead?
  end

  def test_state_method_pass_through
    machine = TestStateMachine.new
    assert_equal 0.16, machine.update(0.16)
    machine.transition_to :dead
    assert_equal 0.32, machine.update(0.16)
  end

  def test_state_method_pass_through_error
    machine = TestStateMachine.new
    assert_raise(NoMethodError) { machine.doesnt_exist }
  end
end
