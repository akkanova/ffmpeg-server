from flask import Flask, send_from_directory, request
from flask.typing import ResponseReturnValue

def create_app() -> Flask:
    app = Flask(__name__)

    # Handle 404 Not Found
    def handle_not_found(error: Exception) -> ResponseReturnValue:
        assert app.static_folder != None
        return send_from_directory(app.static_folder, "404.html")

    app.register_error_handler(404, handle_not_found)

    # API Routes
    @app.get("/api/v1/create-task")
    def create_task() -> ResponseReturnValue:
        return str(request.json)

    return app