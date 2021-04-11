class Application
  def execute_session
    state = initial
    loop do
      choice = state.execute
      break if is_final(state)
      state = transition(state)
    end
    puts "End"
  end

  def is_final(state)
    state.is_a?(FinalState)
  end

  def initial
    HelpState.new
  end

  def transition(state)
    if state.is_a?(HelpState) && state.choice == 1
      FinalState.new
    else
      HelpState.new
    end
  end
end

class State
  attr_reader :choice, :input

  def correct?
  end

  def execute
    ok = false
    until ok
      display
      read
      ok = correct?
      message unless ok
    end
    process
  end

  def message
  end

  def display
  end

  def read
  end

  def process
    puts "Process completed."
  end

  def message
    puts "Please input correct answer."
  end
end

class HelpState < State
  def display
    puts <<~MSG
      Help state
      choice
      1.) Return
    MSG
  end

  def correct?
    @input.chomp == "Return"
  end

  def read
    @input = readline
    if correct?
      @choice = 1
    end
  end
end

class FinalState < State
  def display
    puts "Final state"
  end

  def correct?
    true
  end
end

Application.new.execute_session
