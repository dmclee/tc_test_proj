FROM elixir:1.14-otp-24
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN chmod +x entrypoint.sh
RUN mix local.hex --force && \
  mix local.rebar --force
RUN mix do compile

EXPOSE 4000

CMD ["/app/entrypoint.sh"]