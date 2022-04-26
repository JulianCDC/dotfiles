#!/bin/sh

# Create two audio sinks
# pw-loopback -m '[ FL FR ]' --capture-props='media.class=Audio/Sink node.name=default-sink node.description=Default' &
pw-loopback -m '[ FL FR ]' --capture-props='media.class=Audio/Sink node.name=game-sink node.description=Game' &
pw-loopback -m '[ FL FR ]' --capture-props='media.class=Audio/Sink node.name=chat-sink node.description=Chat' &
pw-loopback -m '[ FL FR ]' --capture-props='media.class=Audio/Sink node.name=music-sink node.description=Music' &
