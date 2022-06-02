ARG version
FROM trinodb/trino:$version

# Obtain root privileges
USER 0

# Setup entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/lib/trino/bin/run-trino"]

# Restore user
USER trino:trino
