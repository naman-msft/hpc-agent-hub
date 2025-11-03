# 🧠 HPC Agent Hub

> **Unified gateway for Azure HPC AI-powered operational intelligence agents**

A beautiful, minimal landing page that serves as the central directory for all HPC AI agents. Built with React, TypeScript, Tailwind CSS, and deployed on Azure Container Apps with automated CI/CD via GitHub Actions.

[![Deploy to Azure](https://github.com/naman-msft/hpc-agent-hub/workflows/Deploy%20HPC%20Agent%20Hub%20to%20Azure%20Container%20Apps/badge.svg)](https://github.com/naman-msft/hpc-agent-hub/actions)
![Azure](https://img.shields.io/badge/Azure-Container%20Apps-0078D4?style=flat-square&logo=microsoft-azure)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)

**Live URL:** [https://hpc-agent-hub-frontend.kindbeach-e15507d6.eastus2.azurecontainerapps.io](https://hpc-agent-hub-frontend.kindbeach-e15507d6.eastus2.azurecontainerapps.io)

---

## 🌟 **Overview**

The HPC Agent Hub is a centralized landing page for Microsoft's Azure HPC & AI team's suite of intelligent agents. As Azure HPC manages thousands of GPU nodes (GB200, H100, MI300X) worth $40K+ each across global datacenters, this hub provides quick access to specialized AI agents that streamline operations.

### **Why This Hub Exists**

Managing high-performance computing infrastructure at scale requires multiple specialized tools:
- **Platform monitoring** for real-time fleet health
- **Incident analysis** for build-out cycle time optimization  
- **Knowledge management** for project-specific expertise

This hub serves as the single entry point to all these capabilities, making it easy for PMs, engineers, and stakeholders to find the right tool for their needs.

---

## 🚀 **Available Agents**

### 1. **[HPC Pulse](https://aka.ms/hpc-pulse)** - Platform Health & Analytics
- AI-powered conversational analytics for Azure HPC infrastructure
- Natural language queries for fleet health, NHIS metrics, and capacity
- Monitors GB200/H100/MI300X clusters worldwide
- **Tech:** Claude 4.5 Sonnet + Azure AI Foundry + Kusto

### 2. **[HPC AI Insights](https://aka.ms/hpc-ai-insights)** - ICM Analysis Dashboard
- Intelligent incident intelligence platform for supercomputing deployments
- Analyzes ICM data, tracks cycle times, detects patterns
- GB200 buildout optimization across datacenters
- **Tech:** Azure OpenAI GPT-4 + Python + React

### 3. **[Fairwater Teams Bot](https://aka.ms/fairwater-teams-agent)** - Project Knowledge
- Grounded knowledge chatbot for Microsoft OpenAI Fairwater project
- Instant answers with contextual information and team expertise
- **Tech:** Microsoft Teams Bot Framework + AI Grounding

---

## 🏗️ **Architecture**

````
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                         │
│                  (naman-msft/hpc-agent-hub)                 │
└───────────────────┬─────────────────────────────────────────┘
                    │ Push to main/master
                    ▼
┌─────────────────────────────────────────────────────────────┐
│              GitHub Actions (OIDC Auth)                      │
│   • Build Frontend (React + Tailwind)                        │
│   • Build Backend (Flask API)                                │
│   • Push images to Azure Container Registry                 │
└───────────────────┬─────────────────────────────────────────┘
                    │ Deploy
                    ▼
┌─────────────────────────────────────────────────────────────┐
│         Azure Container Apps (kindbeach env)                 │
│                                                              │
│  ┌─────────────────────┐      ┌──────────────────────┐     │
│  │  Frontend Container │◄─────┤  Backend Container   │     │
│  │  • React SPA        │      │  • Flask API         │     │
│  │  • Nginx            │      │  • /api/health       │     │
│  │  • Port 80          │      │  • /api/agents       │     │
│  └─────────────────────┘      └──────────────────────┘     │
│           │                                                  │
│           │ Ingress (External)                              │
└───────────┼──────────────────────────────────────────────────┘
            │
            ▼
   hpc-agent-hub-frontend.kindbeach-e15507d6.eastus2.azurecontainerapps.io
````

---

## 💻 **Tech Stack**

### **Frontend**
- **React 18** - UI framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling with custom gradients and animations
- **Lucide React** - Beautiful icons
- **Vite/React Scripts** - Build tooling

### **Backend**
- **Flask** - Python web framework
- **Flask-CORS** - Cross-origin support
- **Gunicorn** - Production WSGI server

### **Infrastructure**
- **Azure Container Apps** - Serverless container hosting
- **Azure Container Registry** - Docker image storage
- **GitHub Actions** - CI/CD pipeline with OIDC authentication
- **Federated Credentials** - Secure, keyless authentication

---

## 🚀 **Quick Start (Local Development)**

### **Prerequisites**
- Python 3.9+
- Node.js 14+
- npm or yarn
- Git

### **Installation**

```bash
# 1. Clone the repository
git clone https://github.com/naman-msft/hpc-agent-hub.git
cd hpc-agent-hub

# 2. Install backend dependencies
pip install -r requirements.txt

# 3. Install frontend dependencies
cd frontend
npm install
cd ..

# 4. Start both servers
chmod +x start.sh
./start.sh
```

**Access the app:**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

**Stop the app:**
Press `Ctrl+C` in the terminal

---

## 📁 **Project Structure**

```
hpc-agent-hub/
├── .github/
│   └── workflows/
│       └── deploy-to-azure.yaml    # CI/CD pipeline
├── frontend/                        # React application
│   ├── public/
│   │   ├── index.html
│   │   └── favicon.ico
│   ├── src/
│   │   ├── components/
│   │   │   └── AgentHub.tsx        # Main hub component
│   │   ├── App.tsx
│   │   ├── index.tsx
│   │   └── index.css               # Tailwind imports
│   ├── Dockerfile                   # Frontend container image
│   ├── nginx.conf                   # Nginx configuration
│   ├── package.json
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   └── tsconfig.json
├── backend/                         # Flask API
│   ├── app.py                       # Main API routes
│   ├── Dockerfile                   # Backend container image
│   └── requirements.txt
├── .dockerignore                    # Docker build exclusions
├── .gitignore
├── start.sh                         # Local development script
├── deploy.sh                        # Azure deployment script
├── requirements.txt                 # Root Python dependencies
└── README.md
```

---

## 🚢 **Deployment**

### **Automated Deployment (GitHub Actions)**

Every push to `main` or `master` triggers automatic deployment:

1. **GitHub Actions** builds Docker images
2. **Images pushed** to Azure Container Registry (`acrhpcagenthub`)
3. **Container Apps updated** with new images
4. **Live in ~5 minutes** ⚡

**Workflow:** [`.github/workflows/deploy-to-azure.yaml`](.github/workflows/deploy-to-azure.yaml)

### **Manual Deployment**

```bash
# Ensure you're logged in to Azure
az login

# Run deployment script
chmod +x deploy.sh
./deploy.sh
```

---

## 🔐 **GitHub Secrets Required**

Configure these secrets in: `Settings` → `Secrets and variables` → `Actions`

| Secret | Value | Description |
|--------|-------|-------------|
| `AZURE_CLIENT_ID` | `598e8b83-4d7e-4c74-b557-abc9d3961da9` | Service principal client ID |
| `AZURE_TENANT_ID` | `72f988bf-86f1-41af-91ab-2d7cd011db47` | Microsoft tenant ID |
| `AZURE_SUBSCRIPTION_ID` | `325e7c34-99fb-4190-aa87-1df746c67705` | Azure subscription ID |
| `RESOURCE_GROUP` | `exec-docs-ai` | Resource group name |
| `ACR_NAME` | `acrhpcagenthub` | Container registry name |
| `APP_NAME` | `hpc-agent-hub` | Container app prefix |
| `FRONTEND_DOMAIN` | `kindbeach-e15507d6.eastus2.azurecontainerapps.io` | Container Apps environment domain |

**Service Principal Setup:**
- Created via Azure Portal → Microsoft Entra ID → App Registrations
- Uses **Federated Credentials** (OIDC) - no secrets stored in GitHub
- Configured for both `main` and `master` branches
- Has `Contributor` role on subscription + `AcrPush` role on ACR

---

## 🎨 **Features**

- ✨ **Stunning Dark UI** - Custom gradient backgrounds with smooth CSS animations
- 🎴 **Interactive Cards** - Hover effects, scale transforms, gradient borders
- 🔗 **aka.ms Links** - Visible short links for easy sharing
- 📱 **Fully Responsive** - Works on desktop, tablet, and mobile
- ⚡ **Lightning Fast** - Static React build served by Nginx
- 🐳 **Container Native** - Docker multi-stage builds for optimal images
- 🔄 **Auto-Deploy** - Push to Git → Live in minutes
- 🛡️ **Secure** - OIDC auth, no secrets in code, CORS configured

---

## 📊 **API Endpoints**

### **GET /api/health**
Health check endpoint for monitoring.

**Response:**
```json
{
  "status": "healthy",
  "service": "HPC Agent Hub",
  "version": "1.0.0"
}
```

### **GET /api/agents**
Returns metadata for all available agents.

**Response:**
```json
[
  {
    "id": "hpc-pulse",
    "name": "HPC Pulse",
    "description": "AI-powered conversational analytics...",
    "link": "https://aka.ms/hpc-pulse",
    "status": "active",
    "badge": "Platform Health"
  },
  ...
]
```

---

## 🔧 **Development**

### **Frontend Development**
```bash
cd frontend
npm start
# Opens http://localhost:3000 with hot reload
```

### **Backend Development**
```bash
cd backend
python app.py
# Runs on http://localhost:5000
```

### **Build Production Images Locally**
```bash
# Frontend
docker build -t hpc-agent-hub-frontend ./frontend

# Backend
docker build -t hpc-agent-hub-backend ./backend
```

---

## 🐛 **Troubleshooting**

### **Port Already in Use**
```bash
# Kill processes on ports 3000 and 5000
kill $(lsof -t -i:3000)
kill $(lsof -t -i:5000)
```

### **Tailwind Styles Not Loading**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### **Container App Unhealthy**
Check logs:
```bash
az containerapp logs show \
  --name hpc-agent-hub-frontend \
  --resource-group exec-docs-ai \
  --tail 100
```

---

## 👥 **Team**

**Built by:** Azure HPC & AI Team  
**Product Manager:** Naman Parikh  
**Organization:** Microsoft Azure High-Performance Computing

**Contact:** For access or questions, reach out via Teams or email.

---

## 📝 **License**

MIT License - Internal Microsoft use

---

## 🔗 **Related Projects**

- **[HPC Pulse](https://github.com/naman-msft/hpc-pulse)** - Platform health monitoring with Claude + Kusto
- **[HPC ICM Analysis](https://github.com/naman-msft/hpc-icm-analysis)** - Incident intelligence dashboard
- **[Fairwater Teams Bot](https://aka.ms/fairwater-teams-agent)** - Project knowledge chatbot

---

## 📈 **Status**

🟢 **All Systems Operational**

- Frontend: ✅ Running
- Backend: ✅ Running  
- CI/CD: ✅ Automated
- Last Deploy: Auto-deployed via GitHub Actions

---

## 🚀 **Future Enhancements**

- [ ] Add authentication/authorization
- [ ] Analytics dashboard for agent usage
- [ ] Search functionality across all agents
- [ ] Admin panel for managing agents
- [ ] Dark/Light mode toggle
- [ ] Agent health monitoring integration

---

**Made with ❤️ for Azure HPC & AI**