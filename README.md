# 🧠 HPC Agent Hub

> **Unified gateway for Azure HPC AI-powered operational intelligence agents**

A beautiful, minimal landing page that serves as the central directory for all HPC AI agents - from infrastructure monitoring to incident analysis to project knowledge management.

![HPC Agent Hub](https://img.shields.io/badge/Azure-HPC%20%26%20AI-0078D4?style=for-the-badge&logo=microsoft-azure)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)

---

## 🌟 **What is this?**

The HPC Agent Hub is a centralized landing page for Microsoft's Azure HPC & AI team's suite of intelligent agents. As Azure HPC manages thousands of GPU nodes (GB200, H100, MI300X) worth $40K+ each across global datacenters, this hub provides quick access to specialized AI agents that streamline operations.

### **Available Agents:**

1. **[HPC Pulse](https://aka.ms/hpc-pulse)** - Platform Health & Analytics
   - AI-powered conversational analytics for Azure HPC infrastructure
   - Natural language queries for fleet health, NHIS metrics, and capacity
   - Monitors GB200/H100/MI300X clusters worldwide

2. **[HPC AI Insights](https://aka.ms/hpc-ai-insights)** - ICM Analysis
   - Intelligent incident intelligence platform for supercomputing deployments
   - Analyzes ICM data, tracks cycle times, detects patterns
   - GB200 buildout optimization across datacenters

3. **[Fairwater Teams Bot](https://teams.microsoft.com/l/app/?source=embedded-builder&titleId=T_726f5869-fadb-132f-a9d4-44fe83d8ffa0)** - Project Knowledge
   - Grounded knowledge chatbot for Microsoft OpenAI Fairwater project
   - Instant answers with contextual information and team expertise

---

## 🚀 **Quick Start (Localhost)**

### **Prerequisites**
- Python 3.9+
- Node.js 14+
- npm or yarn

### **Installation**

```bash
# Clone the repository
git clone https://github.com/naman-msft/hpc-agent-hub.git
cd hpc-agent-hub

# Install dependencies
pip install -r requirements.txt
cd frontend && npm install && cd ..

# Start the application
chmod +x start.sh
./start.sh
```

Visit: **http://localhost:3000**

---

## 📁 **Project Structure**

```
hpc-agent-hub/
├── frontend/              # React + TypeScript + Tailwind CSS
│   ├── src/
│   │   ├── components/
│   │   │   └── AgentHub.tsx    # Main hub component
│   │   ├── App.tsx
│   │   ├── index.tsx
│   │   └── index.css
│   ├── package.json
│   ├── tailwind.config.js
│   └── Dockerfile
├── backend/               # Flask API
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── start.sh              # One-command startup script
├── requirements.txt
└── README.md
```

---

## 🎨 **Features**

- ✨ **Beautiful Dark UI**: Gradient backgrounds with smooth animations
- 🎴 **Agent Cards**: Three beautifully designed cards with hover effects
- 🔗 **Direct Links**: One-click access to all agents via aka.ms links
- 📱 **Responsive Design**: Works perfectly on all devices
- ⚡ **Fast & Lightweight**: Static React app with minimal backend
- 🐳 **Container Ready**: Dockerfile included for Azure Container Apps deployment

---

## 🛠️ **Tech Stack**

- **Frontend**: React 18, TypeScript, Tailwind CSS, Lucide Icons
- **Backend**: Flask, Flask-CORS
- **Deployment**: Azure Container Apps (coming soon)
- **CI/CD**: GitHub Actions (coming soon)

---

## 📊 **API Endpoints**

- `GET /api/health` - Health check
- `GET /api/agents` - List of all available agents

---

## 🚢 **Deployment (Azure Container Apps)**

```bash
# Coming soon - deployment scripts for Azure Container Apps
./deploy.sh
```

---

## 👥 **Team**

Built with ❤️ by the **Azure HPC & AI Team**

- **Product Manager**: Naman Parikh
- **Organization**: Microsoft Azure High-Performance Computing

---

## 📝 **License**

MIT License - See [LICENSE](LICENSE) for details

---

## 🔗 **Related Projects**

- [HPC Pulse](https://github.com/naman-msft/hpc-pulse) - Platform health monitoring agent
- [HPC ICM Analysis](https://github.com/naman-msft/hpc-icm-analysis) - Incident analysis dashboard

---

**Status**: 🟢 All Systems Operational