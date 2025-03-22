FROM redis:latest

# Copy custom Redis configuration
COPY ./redis.conf /usr/local/etc/redis/redis.conf

# Run Redis with the custom configuration
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

EXPOSE 6379