#!/bin/bash
# Docker entrypoint script.

echo "Setting up"
mix ecto.create
mix setup

echo "Done setting up. Starting server"
exec mix phx.server