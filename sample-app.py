from flask import Flask, jsonify
import os, socket

app = Flask(__name__)

@app.route("/")
def index():
	return "<h1>hello world</h1>"

@app.route("/healthz")
def health():
	return jsonify({"status": "healthy"}), 200

@app.route("/info")
def info():
	return jsonify(
		hostname=socket.gethostname(),
		environment=os.environ.get("APP_ENV", "dev")
	)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8090)	