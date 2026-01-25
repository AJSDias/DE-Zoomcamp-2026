FROM python:3.13.11-slim

# To make uv available
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin

# Create working directory inside the container
WORKDIR /code

# Set PATH to include virtual environment binaries
ENV PATH="/code/.venv/bin:$PATH"

# Copy uv files to working directory
COPY pyproject.toml .python-version uv.lock ./

# Install dependencies from uv.lock
RUN uv sync --locked

COPY ingest_data.py .

ENTRYPOINT ["python", "ingest_data.py"]