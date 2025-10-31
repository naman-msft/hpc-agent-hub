# 🧠 HPC Agent Hub

> **Unified gateway for Azure HPC AI-powered operational intelligence agents**

A beautiful, minimal landing page that serves as the central directory for all HPC AI agents - from infrastructure monitoring to incident analysis to project knowledge management.

## 🚀 Quick Start (Localhost)

### Prerequisites
- Python 3.9+
- Node.js 18+
- npm or yarn

### Installation

1. **Clone or create the project structure**
```bash
mkdir hpc-agent-hub
cd hpc-agent-hub
```

2. **Install backend dependencies**
```bash
pip install -r requirements.txt
```

3. **Install frontend dependencies**
```bash
npm run install-all
```

### Run on Localhost

**Option 1: Run separately (recommended for development)**

Terminal 1 - Backend:
```bash
npm run start-backend
# or
cd backend && python app.py
```

Terminal 2 - Frontend:
```bash
npm run start-frontend
# or
cd frontend && npm start
```

**Option 2: Run concurrently**
```bash
npm install  # Install root dependencies (includes concurrently)
npm run dev
```

Visit: **http://localhost:3000**

## 📁 Project Structure

```
hpc-agent-hub/
├── frontend/           # React TypeScript app
│   ├── src/
│   │   ├── components/
│   │   │   └── AgentHub.tsx    # Main hub component
│   │   ├── App.tsx
│   │   └── index.tsx
│   └── package.json
├── backend/            # Flask API
│   └── app.py
├── requirements.txt
├── package.json
└── README.md
```

## 🎨 Features

- **Minimal & Elegant UI**: Dark gradient theme with smooth animations
- **3 Agent Cards**: HPC Pulse, HPC AI Insights, Fairwater Teams Bot
- **Direct Links**: aka.ms links to each agent
- **Responsive Design**: Works on all devices
- **Health Check API**: `/api/health` and `/api/agents` endpoints

## 🔗 Agents

1. **HPC Pulse** - Platform health monitoring (aka.ms/hpc-pulse)
2. **HPC AI Insights** - ICM analysis (aka.ms/hpc-ai-insights)
3. **Fairwater Teams Bot** - Project knowledge chatbot

## 🚢 Next: Deploy to Azure Container Apps

See deployment instructions in the deployment section.

## 📝 License

Microsoft Internal Use