#!/bin/bash

# HPC Agent Hub - Master Startup Script
# Starts both backend and frontend with proper cleanup

set -e  # Exit on error

echo "🚀 Starting HPC Agent Hub..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to cleanup on exit
cleanup() {
    echo ""
    echo -e "${YELLOW}🛑 Shutting down HPC Agent Hub...${NC}"
    
    # Kill backend
    if [ ! -z "$BACKEND_PID" ]; then
        echo "  Stopping backend (PID: $BACKEND_PID)..."
        kill $BACKEND_PID 2>/dev/null || true
    fi
    
    # Kill frontend
    if [ ! -z "$FRONTEND_PID" ]; then
        echo "  Stopping frontend (PID: $FRONTEND_PID)..."
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✅ HPC Agent Hub stopped${NC}"
    exit 0
}

# Trap Ctrl+C and call cleanup
trap cleanup INT TERM

# Check if we're in the right directory
if [ ! -f "start.sh" ]; then
    echo -e "${RED}❌ Error: Please run this script from the hpc-agent-hub root directory${NC}"
    exit 1
fi

# Check prerequisites
echo -e "${BLUE}🔍 Checking prerequisites...${NC}"

# Check Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python3 not found. Please install Python 3.9+${NC}"
    exit 1
fi
echo "  ✅ Python3 found"

# Check Node
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js not found. Please install Node.js 16+${NC}"
    exit 1
fi
echo "  ✅ Node.js found"

# Check npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm not found. Please install npm${NC}"
    exit 1
fi
echo "  ✅ npm found"

echo ""

# Setup Backend
echo -e "${BLUE}📦 Setting up backend...${NC}"

# Check Python dependencies
echo "  🔍 Checking Python dependencies..."
cd backend
if ! python3 -c "import flask, flask_cors" 2>/dev/null; then
    echo -e "${YELLOW}  ⚠️  Dependencies missing. Installing...${NC}"
    pip install -q -r requirements.txt
fi
echo "  ✅ Python dependencies ready"
cd ..

# Setup Frontend
echo ""
echo -e "${BLUE}📦 Setting up frontend...${NC}"
cd frontend

# Install npm dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "  📦 Installing npm dependencies (this may take a minute)..."
    npm install --silent
else
    echo "  ✅ npm dependencies already installed"
fi

cd ..

# Create logs directory
mkdir -p logs

# Kill any existing processes on ports 5000 and 3000
echo ""
echo -e "${BLUE}🧹 Cleaning up existing processes...${NC}"

# Check port 5000 (backend)
if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "  Stopping process on port 5000..."
    kill $(lsof -t -i:5000) 2>/dev/null || true
    sleep 1
fi

# Check port 3000 (frontend)
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "  Stopping process on port 3000..."
    kill $(lsof -t -i:3000) 2>/dev/null || true
    sleep 1
fi

echo "  ✅ Ports cleaned up"

# Start Backend
echo ""
echo -e "${GREEN}🚀 Starting backend on http://localhost:5000${NC}"
cd backend
python3 -u app.py > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
cd ..

# Wait for backend to start
echo "  ⏳ Waiting for backend to start..."
sleep 3

# Check if backend is running
if ! curl -s http://localhost:5000/api/health > /dev/null; then
    echo -e "${RED}❌ Backend failed to start. Check logs/backend.log${NC}"
    tail -20 logs/backend.log
    cleanup
    exit 1
fi
echo -e "${GREEN}  ✅ Backend started (PID: $BACKEND_PID)${NC}"

# Start Frontend
echo ""
echo -e "${GREEN}🚀 Starting frontend on http://localhost:3000${NC}"
cd frontend
BROWSER=none npm start > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
cd ..

# Wait for frontend to start
echo "  ⏳ Waiting for frontend to start..."
sleep 5

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ HPC Agent Hub is running!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  🌐 Frontend: ${BLUE}http://localhost:3000${NC}"
echo -e "  ⚙️  Backend:  ${BLUE}http://localhost:5000${NC}"
echo ""
echo -e "  📊 Logs:"
echo -e "    Backend:  logs/backend.log"
echo -e "    Frontend: logs/frontend.log"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop all services${NC}"
echo ""

# Follow backend logs in foreground (this keeps the script running)
tail -f logs/backend.log