defmodule Firmware.Interface do
  use GenServer

  def start_link(data) do
    GenServer.start_link(__MODULE__, data, name: {:global, :door_interface})
  end

  @impl
  def init(_data) do
    {:ok, button} = Circuits.GPIO.open(27, :input)
    Circuits.GPIO.set_pull_mode(button, :pullup)
    Circuits.GPIO.set_interrupts(button, :both)

    {:ok, led} = Circuits.GPIO.open(5, :output)

    {:ok, %{open: :closed, button: button, led: led, timestamp: 0}}
  end

  @impl
  def handle_info({:circuits_gpio, _pin, timestamp, 0}, data) do
    newstate = case data.open do
                 :open ->
                   Circuits.GPIO.write(data.led, 0)
                   :closed
                 :closed ->
                   Circuits.GPIO.write(data.led, 1)
                   :open
    end
    {:noreply, %{data | open: newstate, timestamp: timestamp}}
  end

  @impl
  def handle_info({:circuits_gpio, _pin, timestamp, 1}, data) do
    {:noreply, data}
  end

  @impl
  def handle_call(:read_state, _from, data) do
    {:reply, %{open: data.open, timestamp: data.timestamp}, data}
  end

end
