import React from 'react';
import { Brain, TrendingUp, BarChart3, MessageCircle, ExternalLink, Sparkles, Link as LinkIcon } from 'lucide-react';

interface Agent {
  id: string;
  name: string;
  description: string;
  icon: JSX.Element;
  link: string;
  akaLink?: string;
  color: string;
  gradient: string;
  badge?: string;
}

const AgentHub: React.FC = () => {
  const agents: Agent[] = [
    {
      id: 'hpc-pulse',
      name: 'HPC Pulse',
      description: 'AI chatbot converting natural language questions into Kusto queries, evolving dashboards with conversational, cross-team insights grounded in real-time HPC data.', 
      icon: <TrendingUp className="w-10 h-10" />,
      link: 'https://aka.ms/hpc-pulse',
      akaLink: 'aka.ms/hpc-pulse',
      color: 'from-blue-500 to-cyan-500',
      gradient: 'hover:from-blue-600 hover:to-cyan-600',
      badge: 'Platform Health'
    },
    {
      id: 'hpc-ai-insights',
      name: 'HPC AI Insights',
      description: 'AI-powered ICM + Cycle Time intelligence dashboard analyzing data and providing cluster level insights for the buildout team.',
      icon: <BarChart3 className="w-10 h-10" />,
      link: 'https://aka.ms/hpc-ai-insights',
      akaLink: 'aka.ms/hpc-ai-insights',
      color: 'from-purple-500 to-pink-500',
      gradient: 'hover:from-purple-600 hover:to-pink-600',
      badge: 'ICM Analysis'
    },
    {
      id: 'fairwater-bot',
      name: 'Fairwater Teams Bot',
      description: 'Grounded Teams chatbot providing instant, context-aware answers about the Microsoft HPC OpenAI Fairwater project with team expertise and documentation.',
      icon: <MessageCircle className="w-10 h-10" />,
      link: 'https://aka.ms/fairwater-teams-agent',
      akaLink: 'aka.ms/fairwater-teams-agent',
      color: 'from-emerald-500 to-teal-500',
      gradient: 'hover:from-emerald-600 hover:to-teal-600',
      badge: 'Teams Chat'
    }
  ];

  return (
    <div className="h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 relative overflow-hidden flex items-center justify-center">
      {/* Animated background elements */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute -top-1/2 -left-1/2 w-full h-full bg-gradient-to-br from-blue-500/10 to-transparent rounded-full blur-3xl animate-pulse"></div>
        <div className="absolute -bottom-1/2 -right-1/2 w-full h-full bg-gradient-to-tl from-purple-500/10 to-transparent rounded-full blur-3xl animate-pulse delay-1000"></div>
      </div>

      {/* Content */}
      <div className="relative z-10 max-w-7xl mx-auto px-6 py-8">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="flex items-center justify-center mb-4 animate-fadeIn">
            <div className="relative">
              <Brain className="h-16 w-16 text-blue-400 animate-pulse" />
              <Sparkles className="h-6 w-6 text-yellow-300 absolute -top-1 -right-1 animate-bounce" />
            </div>
          </div>
          <h1 className="text-5xl font-extrabold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-400 via-purple-400 to-pink-400 animate-fadeIn">
            HPC Agent Hub
          </h1>
          <p className="text-xl text-slate-300 max-w-3xl mx-auto mb-2 animate-fadeIn delay-200">
            AI-Powered Operational Intelligence for Azure HPC
          </p>
        </div>

        {/* Agent Cards */}
        <div className="grid md:grid-cols-3 gap-6 mb-6">
          {agents.map((agent, index) => (
            <a
              key={agent.id}
              href={agent.link}
              target="_blank"
              rel="noopener noreferrer"
              className="group relative"
              style={{ animationDelay: `${index * 150}ms` }}
            >
              <div className="absolute inset-0 bg-gradient-to-r opacity-0 group-hover:opacity-100 transition-opacity duration-500 blur-xl -z-10 from-blue-500/50 to-purple-500/50 rounded-2xl"></div>
              
              <div className="relative h-full bg-slate-800/50 backdrop-blur-xl border border-slate-700/50 rounded-2xl p-6 hover:border-slate-600 transition-all duration-300 hover:scale-105 hover:shadow-2xl">
                {/* Badge */}
                {agent.badge && (
                  <div className="absolute top-3 right-3 px-2 py-1 bg-gradient-to-r from-blue-500/20 to-purple-500/20 border border-blue-400/30 rounded-full">
                    <span className="text-xs font-semibold text-blue-300">{agent.badge}</span>
                  </div>
                )}

                {/* Icon */}
                <div className={`inline-flex p-3 rounded-xl bg-gradient-to-br ${agent.color} ${agent.gradient} transition-all duration-300 mb-4 text-white shadow-lg group-hover:shadow-xl`}>
                  {agent.icon}
                </div>

                {/* Content */}
                <h3 className="text-xl font-bold text-white mb-3 flex items-center gap-2">
                  {agent.name}
                  <ExternalLink className="w-4 h-4 text-slate-400 group-hover:text-blue-400 transition-colors" />
                </h3>
                <p className="text-slate-300 text-sm leading-relaxed mb-4">
                  {agent.description}
                </p>

                {/* aka.ms Link Display */}
                {agent.akaLink && (
                  <div className="flex items-center gap-2 mb-4 px-3 py-2 bg-slate-700/30 rounded-lg border border-slate-600/30">
                    <LinkIcon className="w-3 h-3 text-blue-400" />
                    <span className="text-xs font-mono text-blue-300">{agent.akaLink}</span>
                  </div>
                )}

                {/* Launch Button */}
                <div className={`inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r ${agent.color} rounded-lg text-white text-sm font-semibold shadow-lg group-hover:shadow-xl transition-all duration-300`}>
                  <span>Launch Agent</span>
                  <ExternalLink className="w-3 h-3" />
                </div>
              </div>
            </a>
          ))}
        </div>

        {/* Footer */}
        {/* <div className="text-center">
          <div className="inline-flex items-center gap-3 px-6 py-2 bg-slate-800/30 backdrop-blur-xl border border-slate-700/50 rounded-full">
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
              <span className="text-slate-300 text-sm font-medium">All Systems Operational</span>
            </div>
            <div className="h-4 w-px bg-slate-600"></div>
            <span className="text-slate-400 text-sm">Azure HPC & AI Team</span>
          </div>
        </div> */}
      </div>

      {/* Custom CSS animations */}
      <style>{`
        @keyframes fadeIn {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        .animate-fadeIn {
          animation: fadeIn 0.8s ease-out forwards;
        }

        .delay-200 {
          animation-delay: 200ms;
        }

        .delay-300 {
          animation-delay: 300ms;
        }

        .delay-1000 {
          animation-delay: 1000ms;
        }
      `}</style>
    </div>
  );
};

export default AgentHub;