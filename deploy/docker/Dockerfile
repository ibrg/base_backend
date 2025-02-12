FROM python:3.13-slim-bookworm

# Set the working directory
WORKDIR /www

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Copy from the cache instead of linking since it's a mounted volume
ENV UV_LINK_MODE=copy

# The installer requires curl (and certificates) to download the release archive
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates python3-dev libpq-dev gunicorn

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Create directories for static and media files
RUN mkdir -p /www/staticfiles /www/mediafiles

# Copy the application code
COPY . .

# Make the entrypoint script executable
# RUN chmod +x /www/deploy/docker/entrypoint.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# Create a non-root user and change ownership of the working directory
RUN useradd -m appuser && chown -R appuser:appuser /www

# Switch to the non-root user
USER appuser

# Set the working directory for the application
WORKDIR /www

# Expose the application port
EXPOSE 9000

# Define the entrypoint and command to run the application
# ENTRYPOINT ["/www/deploy/docker/entrypoint.sh"]
# CMD ["uv", "run", "gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:9000"]
CMD [ "uv", "run", "python", "manage.py", "runserver" ]
