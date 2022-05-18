from subprocess import check_output
import pulsectl
import re
import sys

target_sink = str(sys.argv[1])
target_sink_id = None

pulse = pulsectl.Pulse('change_application_sink')

sinks=pulse.sink_list()

chat_sink_id = None
game_sink_id = None
music_sink_id = None

for sink in sinks:
  sink_props = sink.proplist
  sink_name = sink.name
  sink_index = sink.index

  if sink_name == "chat-sink":
    chat_sink_id = sink_index
  elif sink_name == "game-sink":
    game_sink_id = sink_index
  elif sink_name == "music-sink":
    music_sink_id = sink_index

if target_sink == "chat":
  target_sink_id = chat_sink_id
elif target_sink == "game":
  target_sink_id = game_sink_id
elif target_sink == "music":
  target_sink_id = music_sink_id

window = check_output(["xprop"]).decode("utf-8")
window_application_pid = re.search("_NET_WM_PID\(CARDINAL\)\s*=\s*(\d+)", window).group(1)

sink_input_list = pulse.sink_input_list()

for sink_input in sink_input_list:
    try:
      if sink_input.proplist.get("application.process.id") == window_application_pid:
        pulse.sink_input_move(sink_input.index, target_sink_id)
    except:
      pass
