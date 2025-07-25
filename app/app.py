from flask import Flask, jsonify, request
import os
import datetime
import platform

app = Flask(__name__)

# Configuration
app.config['ENV'] = os.getenv('FLASK_ENV', 'production')
app.config['DEBUG'] = os.getenv('FLASK_DEBUG', '0') == '1'

@app.route('/')
def home():
    return jsonify({
        "message": "🚀 Flask Docker Hub App is running!",
        "status": "success",
        "version": "1.0.0",
        "timestamp": datetime.datetime.now().isoformat(),
        "environment": app.config['ENV'],
        "container_info": {
            "platform": platform.platform(),
            "python_version": platform.python_version(),
            "hostname": platform.node()
        }
    })

@app.route('/health')
def health():
    return jsonify({
        "status": "healthy",
        "timestamp": datetime.datetime.now().isoformat(),
        "checks": {
            "flask": "ok",
            "python": "ok",
            "memory": "ok"
        }
    })

@app.route('/api/info')
def info():
    return jsonify({
        "app_name": "Flask Docker Hub Demo",
        "version": "1.0.0",
        "description": "A simple Flask app deployed via Docker Hub",
        "endpoints": {
            "/": "Home page with app info",
            "/health": "Health check endpoint",
            "/api/info": "API information",
            "/api/echo": "Echo service (POST)"
        },
        "docker_hub": "Deployed from Docker Hub! 🐳",
        "github_actions": "Automated CI/CD enabled ✅"
    })

@app.route('/api/echo', methods=['POST'])
def echo():
    data = request.get_json() or {}
    return jsonify({
        "echo": data,
        "timestamp": datetime.datetime.now().isoformat(),
        "message": "Data received successfully!"
    })

@app.errorhandler(404)
def not_found(error):
    return jsonify({
        "error": "Not Found",
        "message": "The requested endpoint does not exist",
        "status_code": 404
    }), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({
        "error": "Internal Server Error",
        "message": "Something went wrong on the server",
        "status_code": 500
    }), 500

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_DEBUG', '0') == '1'
    app.run(host='0.0.0.0', port=port, debug=debug)