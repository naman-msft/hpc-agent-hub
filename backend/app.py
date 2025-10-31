from flask import Flask, send_from_directory, jsonify
from flask_cors import CORS
import os

app = Flask(__name__, static_folder='../frontend/build', static_url_path='')
CORS(app)

@app.route('/api/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'service': 'HPC Agent Hub',
        'version': '1.0.0'
    })

@app.route('/api/agents', methods=['GET'])
def get_agents():
    """Return list of available agents"""
    agents = [
        {
            'id': 'hpc-pulse',
            'name': 'HPC Pulse',
            'description': 'AI-powered conversational analytics for Azure HPC infrastructure',
            'link': 'https://aka.ms/hpc-pulse',
            'status': 'active',
            'badge': 'Platform Health'
        },
        {
            'id': 'hpc-ai-insights',
            'name': 'HPC AI Insights',
            'description': 'Intelligent incident intelligence platform for supercomputing deployments',
            'link': 'https://aka.ms/hpc-ai-insights',
            'status': 'active',
            'badge': 'ICM Analysis'
        },
        {
            'id': 'fairwater-bot',
            'name': 'Fairwater Teams Bot',
            'description': 'Grounded knowledge chatbot for Microsoft OpenAI Fairwater project',
            'link': 'https://teams.microsoft.com/l/app/?source=embedded-builder&titleId=T_726f5869-fadb-132f-a9d4-44fe83d8ffa0',
            'status': 'active',
            'badge': 'Teams Chat'
        }
    ]
    return jsonify(agents)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    """Serve React app"""
    if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, 'index.html')

if __name__ == '__main__':
    print("🚀 Starting HPC Agent Hub...")
    print("📍 Frontend: http://localhost:3000 (development)")
    print("📍 Backend API: http://localhost:5000")
    print("✅ Ready to serve agents!")
    
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=True
    )