FROM fluent/fluentd:v1.12.0-debian-1.0

USER root

RUN ["gem", "install", "fluent-plugin-newrelic"]

USER fluent
