class Command
  attr_reader :name

  def initialize(name, *args)
    @name = name
  end

  def run
    puts "run #{name}"
  end

  def undo
    puts "undo #{name}"
  end
end

class History
  def initialize(size)
    @size = size
    @pos = 0
    @arr = []
    @undo_start = nil
  end

  def push(command)
    @arr[@pos] = command
    @pos = next_pos
  end

  def pop
    @pos = prev_pos
    @arr[@pos]
  end

  def prev_pos
    pos = @pos - 1
    pos >= 0 ? pos : @size - 1
  end

  def next_pos
    pos = @pos + 1
    pos <= @size - 1 ? pos : 0
  end
end

class Application
  attr_reader :history

  def initialize
    @history = History.new(100)
  end

  def run(name)
    command = Command.new(name)
    command.run
    @history.push(command)
  end

  def undo
    command = @history.pop
    raise "There are no commands to undo." if command.nil?

    command.undo
  end
end

app = Application.new
app.run("Good thing")
app.run("Bad thing")
app.run("Good thing2")
app.undo
app.undo
app.undo
app.run("Good thing")
app.run("Bad thing")
app.run("Good thing2")
app.undo
app.undo
app.undo
app.undo
