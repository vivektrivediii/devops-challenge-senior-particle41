from flask import Flask, request, jsonify
from datetime import datetime
import socket

app = Flask(__name__)

@app.route("/", methods=["GET"])
def home():
    visitor_ip = request.remote_addr
    return jsonify({
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "ip": visitor_ip
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
