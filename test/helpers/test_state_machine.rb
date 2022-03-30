class TestStateMachine
  class State
    class Alive
      def update(delta)
        delta
      end
    end

    class Dead
      def update(delta)
        delta * 2
      end
    end
  end

  include StateMachine
  state_machine(
    states: {
      alive: TestStateMachine::State::Alive,
      dead: TestStateMachine::State::Dead,
    },
    methods: [:update]
  )

  def initialize
    transition_to :alive
  end
end
