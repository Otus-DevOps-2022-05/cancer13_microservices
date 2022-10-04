FROM fluent/fluentd:edge
USER root
RUN gem install elasticsearch -v 7.16.3 && \
    gem install fluent-plugin-elasticsearch && \
    gem install fluent-plugin-rewrite-tag-filter && \
    gem install fluent-plugin-multi-format-parser && \
    gem install fluent-plugin-grok-parser
ADD fluent.conf /fluentd/etc
USER fluent
