runserver:
	uv run python src/manage.py runserver

makemigrations:
	uv run python src/manage.py makemigrations

migrate:
	uv run python src/manage.py migrate
