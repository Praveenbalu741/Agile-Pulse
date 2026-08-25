$staticDir = "c:/Users/prave/Downloads/Agile Pulse/src/main/resources/static"

# Create directories
New-Item -ItemType Directory -Force -Path "$staticDir/css" | Out-Null
New-Item -ItemType Directory -Force -Path "$staticDir/js" | Out-Null
New-Item -ItemType Directory -Force -Path "$staticDir/assets" | Out-Null

$indexHtml = @"
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agile Pulse | Internal Culture & Ops Platform</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        brand: {
                            500: '#8b5cf6',
                            600: '#7c3aed',
                        },
                        dark: {
                            900: '#0f172a',
                            800: '#1e293b',
                            700: '#334155'
                        }
                    }
                }
            }
        }
    </script>
    <!-- Custom Styles -->
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body class="bg-dark-900 text-white font-sans antialiased min-h-screen flex overflow-hidden">
    
    <!-- Sidebar -->
    <aside class="w-64 bg-dark-800 glass-panel border-r border-dark-700/50 flex flex-col z-20">
        <div class="p-6 flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-500 to-purple-600 shadow-lg shadow-brand-500/30 flex items-center justify-center font-bold text-xl">
                AP
            </div>
            <h1 class="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-400">Agile Pulse</h1>
        </div>
        
        <nav class="flex-1 px-4 space-y-2 mt-4">
            <button class="nav-btn active w-full text-left px-4 py-3 rounded-xl transition-all duration-300" data-view="dashboard">
                <span class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                    Executive Dashboard
                </span>
            </button>
            <button class="nav-btn w-full text-left px-4 py-3 rounded-xl transition-all duration-300" data-view="standup">
                <span class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    Daily Standup
                </span>
            </button>
            <button class="nav-btn w-full text-left px-4 py-3 rounded-xl transition-all duration-300" data-view="kanban">
                <span class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>
                    Sprint Board
                </span>
            </button>
            <button class="nav-btn w-full text-left px-4 py-3 rounded-xl transition-all duration-300" data-view="kudos">
                <span class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path></svg>
                    Kudos Wall
                </span>
            </button>
            <button class="nav-btn w-full text-left px-4 py-3 rounded-xl transition-all duration-300" data-view="casestudy">
                <span class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path></svg>
                    Case Study
                </span>
            </button>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 relative overflow-y-auto bg-[radial-gradient(ellipse_at_top_right,_var(--tw-gradient-stops))] from-dark-800 via-dark-900 to-black z-10">
        
        <!-- Glowing Orbs Background -->
        <div class="fixed top-0 right-0 w-[500px] h-[500px] bg-brand-600/20 rounded-full blur-[120px] pointer-events-none"></div>
        <div class="fixed bottom-0 left-64 w-[500px] h-[500px] bg-purple-600/10 rounded-full blur-[100px] pointer-events-none"></div>

        <div class="p-8 pb-20 relative z-20">
            <!-- Header -->
            <header class="flex justify-between items-center mb-8">
                <h2 id="pageTitle" class="text-3xl font-bold tracking-tight">Executive Dashboard</h2>
                <div class="flex items-center gap-4">
                    <div class="glass-panel px-4 py-2 rounded-full text-sm font-medium border border-dark-700/50 flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-green-400 animate-pulse"></span>
                        System Online
                    </div>
                    <img src="https://ui-avatars.com/api/?name=Admin&background=8b5cf6&color=fff" alt="Profile" class="w-10 h-10 rounded-full border-2 border-brand-500/50 cursor-pointer hover:border-brand-500 transition-colors">
                </div>
            </header>

            <!-- Views Container -->
            <div id="views-container" class="relative min-h-[500px]">
                
                <!-- Dashboard View -->
                <section id="view-dashboard" class="view-section active grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="glass-card p-6 rounded-2xl flex flex-col">
                        <h3 class="text-gray-400 text-sm font-medium mb-1">Sprint Velocity</h3>
                        <div class="text-3xl font-bold mb-4">85 <span class="text-lg text-gray-500 font-normal">pts</span></div>
                        <div class="mt-auto h-32 relative">
                            <canvas id="velocityChart"></canvas>
                        </div>
                    </div>
                    <div class="glass-card p-6 rounded-2xl flex flex-col">
                        <h3 class="text-gray-400 text-sm font-medium mb-1">Burndown Summary</h3>
                        <div class="text-3xl font-bold mb-4">34 <span class="text-lg text-gray-500 font-normal">/ 40 pts</span></div>
                        <div class="mt-auto w-full bg-dark-700 rounded-full h-4 overflow-hidden relative">
                            <div class="bg-gradient-to-r from-brand-500 to-purple-500 h-full rounded-full w-[85%] relative">
                                <div class="absolute inset-0 bg-white/20 shimmer-effect"></div>
                            </div>
                        </div>
                    </div>
                    <div class="glass-card p-6 rounded-2xl flex flex-col">
                        <h3 class="text-gray-400 text-sm font-medium mb-1">Team Morale</h3>
                        <div class="text-3xl font-bold text-green-400 mb-4">8.5 <span class="text-lg text-gray-500 font-normal">/ 10</span></div>
                        <div class="mt-auto flex justify-between items-end h-16">
                            <div class="w-6 bg-dark-700 rounded-t-md h-8"></div>
                            <div class="w-6 bg-dark-700 rounded-t-md h-10"></div>
                            <div class="w-6 bg-brand-500/50 rounded-t-md h-12"></div>
                            <div class="w-6 bg-brand-500 rounded-t-md h-16"></div>
                            <div class="w-6 bg-brand-400 rounded-t-md h-14"></div>
                        </div>
                    </div>
                </section>

                <!-- Kanban View -->
                <section id="view-kanban" class="view-section hidden h-full">
                    <div class="flex gap-6 overflow-x-auto pb-4 h-[70vh]" id="kanban-board">
                        <!-- Columns will be injected by JS -->
                    </div>
                </section>

                <!-- Standup View -->
                <section id="view-standup" class="view-section hidden">
                    <div class="max-w-2xl mx-auto glass-card p-8 rounded-3xl relative overflow-hidden">
                        <div class="absolute top-0 right-0 p-8 opacity-10">
                            <svg class="w-32 h-32" fill="currentColor" viewBox="0 0 24 24"><path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        </div>
                        <h3 class="text-2xl font-bold mb-6">Daily Check-in</h3>
                        <form id="standupForm" class="space-y-6 relative z-10">
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-2">Team Member</label>
                                <input type="text" id="su-name" required class="w-full bg-dark-900/50 border border-dark-700 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-500 transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-2">What did you do yesterday?</label>
                                <textarea id="su-yesterday" required rows="2" class="w-full bg-dark-900/50 border border-dark-700 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-500 transition-all"></textarea>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-2">What are you doing today?</label>
                                <textarea id="su-today" required rows="2" class="w-full bg-dark-900/50 border border-dark-700 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-500 transition-all"></textarea>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-2">Any blockers?</label>
                                <input type="text" id="su-blockers" value="None" class="w-full bg-dark-900/50 border border-dark-700 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-500 transition-all">
                            </div>
                            <button type="submit" class="w-full bg-brand-600 hover:bg-brand-500 text-white font-semibold py-3 px-6 rounded-xl transition-all duration-300 transform hover:scale-[1.02] shadow-lg shadow-brand-500/25 flex justify-center items-center gap-2">
                                Submit Check-in
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </button>
                        </form>
                    </div>
                </section>

                <!-- Kudos View -->
                <section id="view-kudos" class="view-section hidden">
                    <div class="flex justify-between items-center mb-8">
                        <div>
                            <h3 class="text-xl font-bold">Pulse Stars</h3>
                            <p class="text-gray-400">Recognize your team members for their great work.</p>
                        </div>
                        <button onclick="document.getElementById('kudosModal').classList.remove('hidden')" class="bg-brand-600 hover:bg-brand-500 text-white px-5 py-2.5 rounded-xl font-medium transition-colors shadow-lg shadow-brand-500/25">
                            + Give Kudos
                        </button>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="kudos-grid">
                        <!-- Kudos cards injected via JS -->
                    </div>
                </section>

                <!-- Case Study View -->
                <section id="view-casestudy" class="view-section hidden">
                    <div class="glass-card p-8 rounded-3xl max-w-4xl mx-auto">
                        <div class="flex items-center gap-4 mb-6">
                            <div class="w-12 h-12 rounded-xl bg-blue-500/20 text-blue-400 flex items-center justify-center">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path></svg>
                            </div>
                            <div>
                                <h3 class="text-2xl font-bold">Agile Pulse UI/UX Design System</h3>
                                <p class="text-brand-400">Architecture & Design Decisions</p>
                            </div>
                        </div>
                        <div class="prose prose-invert max-w-none text-gray-300 space-y-6">
                            <p>This internal tool leverages a <strong>Glassmorphism</strong> design pattern combined with a deeply tailored Dark Mode. The goal is to provide a premium, dynamic feel for internal tools which are often neglected in terms of UX.</p>
                            
                            <h4 class="text-white text-lg font-semibold mt-4">Tech Stack Synergy</h4>
                            <ul class="list-disc pl-5 space-y-2">
                                <li><strong>Java / Spring Boot:</strong> Robust, heavily-typed backend ensures enterprise-grade stability and strict data contracts via REST APIs.</li>
                                <li><strong>Vanilla JavaScript (ES6+):</strong> We deliberately avoided heavy frontend frameworks (React/Angular) to keep the repository language strictly Java, demonstrating mastery over modern DOM APIs, Intersection Observers, and Event Delegation.</li>
                                <li><strong>Tailwind CSS via CDN:</strong> Allows rapid, utility-first styling with custom configurations injected at runtime.</li>
                            </ul>

                            <h4 class="text-white text-lg font-semibold mt-4">Micro-Interactions</h4>
                            <p>Subtle animations on hover, drag-and-drop state transitions, and asynchronous UI updates create a "living" application. The Kanban board utilizes native HTML5 Drag and Drop API with custom CSS scaling effects to simulate physical cards being picked up.</p>
                        </div>
                    </div>
                </section>
                
            </div>
        </div>
    </main>

    <!-- Modals & Overlays -->
    <div id="kudosModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 hidden flex items-center justify-center">
        <div class="bg-dark-800 border border-dark-700 rounded-2xl w-full max-w-md p-6 transform scale-95 opacity-0 transition-all duration-300" id="kudosModalContent">
            <h3 class="text-xl font-bold mb-4 text-white">Give Kudos</h3>
            <form id="kudosForm" class="space-y-4">
                <div>
                    <label class="block text-sm text-gray-400 mb-1">To</label>
                    <input type="text" id="kudos-to" required class="w-full bg-dark-900 border border-dark-700 rounded-lg px-3 py-2 text-white">
                </div>
                <div>
                    <label class="block text-sm text-gray-400 mb-1">Message</label>
                    <textarea id="kudos-msg" required rows="3" class="w-full bg-dark-900 border border-dark-700 rounded-lg px-3 py-2 text-white"></textarea>
                </div>
                <div class="flex justify-end gap-3 mt-6">
                    <button type="button" onclick="closeKudosModal()" class="px-4 py-2 text-gray-400 hover:text-white transition-colors">Cancel</button>
                    <button type="submit" class="bg-brand-600 hover:bg-brand-500 text-white px-4 py-2 rounded-lg font-medium transition-colors">Send Kudos 🎉</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="/js/api.js"></script>
    <script src="/js/dashboard.js"></script>
    <script src="/js/kanban.js"></script>
    <script src="/js/standup.js"></script>
    <script src="/js/kudos.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>
"@
Set-Content -Path "$staticDir/index.html" -Value $indexHtml

$cssStyles = @"
/* Custom CSS for Glassmorphism & Animations */

.glass-panel {
    background: rgba(30, 41, 59, 0.4);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
}

.glass-card {
    background: linear-gradient(145deg, rgba(30, 41, 59, 0.6) 0%, rgba(15, 23, 42, 0.8) 100%);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.05);
    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
    transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
}

.glass-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 40px 0 rgba(0, 0, 0, 0.4);
    border-color: rgba(139, 92, 246, 0.3);
}

.nav-btn {
    position: relative;
    color: #94a3b8;
}

.nav-btn:hover {
    color: #fff;
    background: rgba(255, 255, 255, 0.05);
}

.nav-btn.active {
    color: #fff;
    background: linear-gradient(90deg, rgba(139, 92, 246, 0.15) 0%, transparent 100%);
    border-left: 3px solid #8b5cf6;
}

.view-section {
    animation: fadeIn 0.4s ease-out forwards;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Kanban Drag & Drop Styles */
.kanban-column {
    min-width: 320px;
    background: rgba(15, 23, 42, 0.4);
    border-radius: 1rem;
    padding: 1rem;
    display: flex;
    flex-direction: column;
}

.kanban-card {
    cursor: grab;
}

.kanban-card:active {
    cursor: grabbing;
}

.kanban-card.dragging {
    opacity: 0.5;
    transform: scale(0.95);
}

.kanban-column.drag-over {
    background: rgba(139, 92, 246, 0.1);
    border: 1px dashed rgba(139, 92, 246, 0.5);
}

/* Custom Scrollbar */
::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}
::-webkit-scrollbar-track {
    background: transparent;
}
::-webkit-scrollbar-thumb {
    background: #334155;
    border-radius: 3px;
}
::-webkit-scrollbar-thumb:hover {
    background: #475569;
}

.shimmer-effect {
    animation: shimmer 2s infinite linear;
    background: linear-gradient(to right, transparent 0%, rgba(255,255,255,0.3) 50%, transparent 100%);
    background-size: 200% 100%;
}

@keyframes shimmer {
    0% { transform: translateX(-100%); }
    100% { transform: translateX(100%); }
}

/* Confetti */
.confetti {
    position: fixed;
    width: 10px;
    height: 10px;
    background-color: #f00;
    animation: fall 3s linear forwards;
    z-index: 1000;
}

@keyframes fall {
    to { transform: translateY(100vh) rotate(360deg); opacity: 0; }
}
"@
Set-Content -Path "$staticDir/css/styles.css" -Value $cssStyles

$apiJs = @"
const API_BASE = '/api/v1';

async function fetchAPI(endpoint, options = {}) {
    try {
        const res = await fetch(`\${API_BASE}\${endpoint}`, {
            headers: {
                'Content-Type': 'application/json'
            },
            ...options
        });
        if (!res.ok) throw new Error(`HTTP error! status: \${res.status}`);
        return await res.json();
    } catch (error) {
        console.error('API Error:', error);
        return null;
    }
}

window.api = {
    getStandups: () => fetchAPI('/standups'),
    createStandup: (data) => fetchAPI('/standups', { method: 'POST', body: JSON.stringify(data) }),
    updateStandupStatus: (id, status) => fetchAPI(`/standups/\${id}/status`, { method: 'PATCH', body: JSON.stringify({status}) }),
    getKudos: () => fetchAPI('/kudos'),
    createKudo: (data) => fetchAPI('/kudos', { method: 'POST', body: JSON.stringify(data) })
};
"@
Set-Content -Path "$staticDir/js/api.js" -Value $apiJs

$dashboardJs = @"
function initDashboard() {
    const ctx = document.getElementById('velocityChart')?.getContext('2d');
    if(!ctx) return;
    
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Completed', 'Remaining'],
            datasets: [{
                data: [85, 15],
                backgroundColor: ['#8b5cf6', '#334155'],
                borderWidth: 0,
                cutout: '75%'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            animation: { animateScale: true, animateRotate: true }
        }
    });
}
"@
Set-Content -Path "$staticDir/js/dashboard.js" -Value $dashboardJs

$kanbanJs = @"
const KANBAN_COLS = [
    { id: 'TO_DO', title: 'To Do', color: 'gray' },
    { id: 'IN_PROGRESS', title: 'In Progress', color: 'blue' },
    { id: 'REVIEW', title: 'Review', color: 'yellow' },
    { id: 'DONE', title: 'Done', color: 'green' }
];

async function loadKanban() {
    const container = document.getElementById('kanban-board');
    if(!container) return;
    
    container.innerHTML = ''; // clear
    
    // Create columns
    KANBAN_COLS.forEach(col => {
        const colDiv = document.createElement('div');
        colDiv.className = 'kanban-column';
        colDiv.dataset.status = col.id;
        
        colDiv.innerHTML = `
            <div class="flex justify-between items-center mb-4">
                <h4 class="font-semibold text-gray-200">\${col.title}</h4>
                <span class="bg-dark-700 text-xs px-2 py-1 rounded-md" id="count-\${col.id}">0</span>
            </div>
            <div class="flex-1 space-y-3 kanban-dropzone overflow-y-auto" data-status="\${col.id}"></div>
        `;
        container.appendChild(colDiv);
        
        // Setup dropzone
        const dropzone = colDiv.querySelector('.kanban-dropzone');
        dropzone.addEventListener('dragover', e => {
            e.preventDefault();
            colDiv.classList.add('drag-over');
        });
        dropzone.addEventListener('dragleave', e => {
            colDiv.classList.remove('drag-over');
        });
        dropzone.addEventListener('drop', async e => {
            e.preventDefault();
            colDiv.classList.remove('drag-over');
            const cardId = e.dataTransfer.getData('text/plain');
            const card = document.getElementById(cardId);
            if(card) {
                dropzone.appendChild(card);
                updateCounts();
                // API Call
                const id = cardId.replace('card-', '');
                await window.api.updateStandupStatus(id, col.id);
            }
        });
    });

    // Load data
    const standups = await window.api.getStandups();
    if(standups) {
        standups.forEach(item => {
            const card = createCard(item);
            const dropzone = document.querySelector(`.kanban-dropzone[data-status="\${item.status}"]`);
            if(dropzone) {
                dropzone.appendChild(card);
            }
        });
    }
    updateCounts();
}

function createCard(item) {
    const el = document.createElement('div');
    el.className = 'kanban-card bg-dark-800 border border-dark-700 p-4 rounded-xl shadow-lg relative group';
    el.id = `card-\${item.id}`;
    el.draggable = true;
    
    el.innerHTML = `
        <div class="flex justify-between items-start mb-2">
            <span class="text-brand-400 font-medium text-sm">\${item.teamMember}</span>
            <span class="text-xs text-gray-500">\${item.date}</span>
        </div>
        <p class="text-gray-300 text-sm line-clamp-2" title="\${item.today}">\${item.today}</p>
    `;
    
    el.addEventListener('dragstart', e => {
        el.classList.add('dragging');
        e.dataTransfer.setData('text/plain', el.id);
    });
    
    el.addEventListener('dragend', () => {
        el.classList.remove('dragging');
    });
    
    return el;
}

function updateCounts() {
    KANBAN_COLS.forEach(col => {
        const count = document.querySelector(`.kanban-dropzone[data-status="\${col.id}"]`).children.length;
        document.getElementById(`count-\${col.id}`).innerText = count;
    });
}
"@
Set-Content -Path "$staticDir/js/kanban.js" -Value $kanbanJs

$standupJs = @"
function initStandupForm() {
    const form = document.getElementById('standupForm');
    if(!form) return;
    
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const data = {
            teamMember: document.getElementById('su-name').value,
            yesterday: document.getElementById('su-yesterday').value,
            today: document.getElementById('su-today').value,
            blockers: document.getElementById('su-blockers').value,
            status: 'TO_DO',
            date: new Date().toISOString().split('T')[0]
        };
        
        const res = await window.api.createStandup(data);
        if(res) {
            alert('Check-in submitted successfully!');
            form.reset();
            // Optional: trigger kanban reload if in background
        }
    });
}
"@
Set-Content -Path "$staticDir/js/standup.js" -Value $standupJs

$kudosJs = @"
async function loadKudos() {
    const container = document.getElementById('kudos-grid');
    if(!container) return;
    
    const kudos = await window.api.getKudos();
    if(!kudos) return;
    
    container.innerHTML = kudos.map(k => `
        <div class="glass-card p-6 rounded-2xl relative overflow-hidden group">
            <div class="absolute -right-4 -top-4 w-24 h-24 bg-yellow-500/10 rounded-full blur-xl group-hover:bg-yellow-500/20 transition-colors"></div>
            <div class="flex items-center gap-2 mb-4">
                <span class="text-2xl">🌟</span>
                <div>
                    <div class="font-bold">\${k.receiver}</div>
                    <div class="text-xs text-gray-400">from \${k.sender}</div>
                </div>
            </div>
            <p class="text-gray-300 text-sm italic">"\${k.message}"</p>
        </div>
    `).join('');
}

function initKudosForm() {
    const form = document.getElementById('kudosForm');
    if(!form) return;
    
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const data = {
            sender: 'Admin', // Hardcoded for demo
            receiver: document.getElementById('kudos-to').value,
            message: document.getElementById('kudos-msg').value
        };
        
        const res = await window.api.createKudo(data);
        if(res) {
            closeKudosModal();
            triggerConfetti();
            loadKudos();
        }
    });
}

function closeKudosModal() {
    const modal = document.getElementById('kudosModal');
    const content = document.getElementById('kudosModalContent');
    content.classList.remove('scale-100', 'opacity-100');
    content.classList.add('scale-95', 'opacity-0');
    setTimeout(() => modal.classList.add('hidden'), 300);
}

document.getElementById('kudosModal')?.addEventListener('click', (e) => {
    if(e.target.id === 'kudosModal') closeKudosModal();
});

function triggerConfetti() {
    for(let i=0; i<50; i++) {
        const conf = document.createElement('div');
        conf.className = 'confetti';
        conf.style.left = Math.random() * 100 + 'vw';
        conf.style.backgroundColor = ['#8b5cf6', '#ec4899', '#f59e0b', '#3b82f6'][Math.floor(Math.random() * 4)];
        conf.style.animationDuration = (Math.random() * 2 + 2) + 's';
        document.body.appendChild(conf);
        setTimeout(() => conf.remove(), 4000);
    }
}

// Intercept opening modal for animation
const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
        if (mutation.target.id === 'kudosModal' && !mutation.target.classList.contains('hidden')) {
            setTimeout(() => {
                const content = document.getElementById('kudosModalContent');
                content.classList.remove('scale-95', 'opacity-0');
                content.classList.add('scale-100', 'opacity-100');
            }, 10);
        }
    });
});
if(document.getElementById('kudosModal')) {
    observer.observe(document.getElementById('kudosModal'), { attributes: true, attributeFilter: ['class'] });
}
"@
Set-Content -Path "$staticDir/js/kudos.js" -Value $kudosJs

$appJs = @"
document.addEventListener('DOMContentLoaded', () => {
    
    // View Switching
    const navBtns = document.querySelectorAll('.nav-btn');
    const views = document.querySelectorAll('.view-section');
    const pageTitle = document.getElementById('pageTitle');
    
    navBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Update nav active state
            navBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            // Update title
            pageTitle.innerText = btn.innerText.trim();
            
            // Switch view
            const viewId = btn.getAttribute('data-view');
            views.forEach(v => {
                if(v.id === `view-\${viewId}`) {
                    v.classList.remove('hidden');
                    v.classList.add('active');
                } else {
                    v.classList.add('hidden');
                    v.classList.remove('active');
                }
            });
            
            // Trigger specific view initializations
            if(viewId === 'kanban') loadKanban();
            if(viewId === 'kudos') loadKudos();
        });
    });
    
    // Initializations
    initDashboard();
    initStandupForm();
    initKudosForm();
});
"@
Set-Content -Path "$staticDir/js/app.js" -Value $appJs
