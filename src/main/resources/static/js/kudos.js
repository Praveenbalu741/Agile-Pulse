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
                    <div class="font-bold">${k.receiver}</div>
                    <div class="text-xs text-gray-400">from ${k.sender}</div>
                </div>
            </div>
            <p class="text-gray-300 text-sm italic">"${k.message}"</p>
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
