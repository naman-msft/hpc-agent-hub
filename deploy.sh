#!/bin/bash

# ===================================
# HPC Agent Hub Deployment Script
# ===================================

SUBSCRIPTION_ID="325e7c34-99fb-4190-aa87-1df746c67705"
RESOURCE_GROUP="exec-docs-ai"
LOCATION="eastus2"
APP_NAME="hpc-agent-hub"
ACR_NAME="acrhpcagenthub"
CONTAINER_APP_ENV="env-hpc-pulse"  # Reuse existing environment

echo "🚀 HPC Agent Hub - Azure Container Apps Deployment"
echo "================================================"
echo "Subscription: $SUBSCRIPTION_ID"
echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
echo ""

# Login to Azure
echo "🔐 Logging into Azure..."
az account set --subscription $SUBSCRIPTION_ID

# Create resource group (idempotent)
echo "📦 Ensuring resource group exists..."
az group create --name $RESOURCE_GROUP --location $LOCATION 2>/dev/null || true

# Create Azure Container Registry
echo "🏗️  Creating Azure Container Registry..."
az acr create \
  --resource-group $RESOURCE_GROUP \
  --name $ACR_NAME \
  --sku Basic \
  --admin-enabled true \
  --location $LOCATION 2>/dev/null || echo "ACR already exists"

# Get ACR credentials
echo "🔑 Getting ACR credentials..."
ACR_LOGIN_SERVER=$(az acr show -n $ACR_NAME -g $RESOURCE_GROUP --query loginServer -o tsv)
ACR_USERNAME=$(az acr credential show -n $ACR_NAME -g $RESOURCE_GROUP --query username -o tsv)
ACR_PASSWORD=$(az acr credential show -n $ACR_NAME -g $RESOURCE_GROUP --query passwords[0].value -o tsv)

echo "ACR Login Server: $ACR_LOGIN_SERVER"

# Build and push backend image
echo ""
echo "🔨 Building backend image..."
az acr build \
  --registry $ACR_NAME \
  --image backend:latest \
  --file ./backend/Dockerfile \
  ./backend

# Check if Container Apps environment exists, create if not
echo ""
echo "🌍 Ensuring Container Apps environment exists..."
az containerapp env show \
  --name $CONTAINER_APP_ENV \
  --resource-group $RESOURCE_GROUP 2>/dev/null || \
az containerapp env create \
  --name $CONTAINER_APP_ENV \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION

# Deploy backend (simple - no auth, no env vars needed)
echo ""
echo "🖥️  Deploying backend container app..."
az containerapp create \
  --name "${APP_NAME}-backend" \
  --resource-group $RESOURCE_GROUP \
  --environment $CONTAINER_APP_ENV \
  --image "${ACR_LOGIN_SERVER}/backend:latest" \
  --registry-server $ACR_LOGIN_SERVER \
  --registry-username $ACR_USERNAME \
  --registry-password $ACR_PASSWORD \
  --target-port 5000 \
  --ingress external \
  --min-replicas 1 \
  --max-replicas 2 \
  --cpu 0.5 \
  --memory 1.0Gi \
  --env-vars \
    FLASK_ENV=production 2>/dev/null || \
az containerapp update \
  --name "${APP_NAME}-backend" \
  --resource-group $RESOURCE_GROUP \
  --image "${ACR_LOGIN_SERVER}/backend:latest"

BACKEND_URL=$(az containerapp show -n "${APP_NAME}-backend" -g $RESOURCE_GROUP --query properties.configuration.ingress.fqdn -o tsv)

echo "Backend URL: https://$BACKEND_URL"

# Update nginx.conf with actual backend URL
echo ""
echo "📝 Updating nginx.conf with backend URL..."
sed "s|hpc-agent-hub-backend.kindbeach-e15507d6.eastus2.azurecontainerapps.io|$BACKEND_URL|g" frontend/nginx.conf > frontend/nginx.conf.tmp
mv frontend/nginx.conf.tmp frontend/nginx.conf

# Build and push frontend image
echo ""
echo "🔨 Building frontend image..."
az acr build \
  --registry $ACR_NAME \
  --image frontend:latest \
  --file ./frontend/Dockerfile \
  ./frontend

# Deploy frontend
echo ""
echo "🎨 Deploying frontend container app..."
az containerapp create \
  --name "${APP_NAME}-frontend" \
  --resource-group $RESOURCE_GROUP \
  --environment $CONTAINER_APP_ENV \
  --image "${ACR_LOGIN_SERVER}/frontend:latest" \
  --registry-server $ACR_LOGIN_SERVER \
  --registry-username $ACR_USERNAME \
  --registry-password $ACR_PASSWORD \
  --target-port 80 \
  --ingress external \
  --min-replicas 1 \
  --max-replicas 3 \
  --cpu 0.5 \
  --memory 1.0Gi 2>/dev/null || \
az containerapp update \
  --name "${APP_NAME}-frontend" \
  --resource-group $RESOURCE_GROUP \
  --image "${ACR_LOGIN_SERVER}/frontend:latest"

FRONTEND_URL=$(az containerapp show -n "${APP_NAME}-frontend" -g $RESOURCE_GROUP --query properties.configuration.ingress.fqdn -o tsv)

echo ""
echo "🎉 DEPLOYMENT COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📱 Frontend URL:  https://$FRONTEND_URL"
echo "🖥️  Backend URL:   https://$BACKEND_URL"
echo "🏗️  ACR Name:      $ACR_NAME"
echo "📦 Resource Group: $RESOURCE_GROUP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ NO MANUAL STEPS NEEDED - App is ready to use!"
echo ""

# Save deployment info
cat > deployment_info.txt << EOF
HPC Agent Hub Deployment Info
Generated: $(date)

Frontend URL: https://$FRONTEND_URL
Backend URL: https://$BACKEND_URL
ACR Name: $ACR_NAME
ACR Login Server: $ACR_LOGIN_SERVER
Resource Group: $RESOURCE_GROUP
Container App Environment: $CONTAINER_APP_ENV
EOF

echo "📝 Deployment info saved to deployment_info.txt"