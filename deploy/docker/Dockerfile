FROM python:3.13-slim-bookworm

# Set the working directory
WORKDIR /www
# The installer requires curl (and certificates) to download the release archive
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# Create directories for static and media files
RUN mkdir -p /www/staticfiles /www/mediafiles

# Copy the project into the image
ADD . /www

# Sync the project into a new environment, using the frozen lockfile
WORKDIR /www
RUN uv sync --frozen

# Create a non-root user and change ownership of the working directory
RUN useradd -m appuser && chown -R appuser:appuser /www

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 9000
WORKDIR /www/src

# CMD ["uv", "run", "gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:9000"]
