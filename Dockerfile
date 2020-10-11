FROM ioribranford/godot-docker:3.2.2

COPY . /game/
WORKDIR /game/

CMD godot -s addons/gut/gut_cmdln.gd --path $PWD -gdir=res://tests -gexit

# docker build --tag game-of-life:1.0 .
# docker run game-of-life:1.0
# docker run -it --entrypoint bash game-of-life:1.0
