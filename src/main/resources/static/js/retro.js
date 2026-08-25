const RETRO_TYPES = {
    START: { emoji: '🟢', label: 'Start', color: 'green' },
    STOP: { emoji: '🔴', label: 'Stop', color: 'red' },
    CONTINUE: { emoji: '🔵', label: 'Continue', color: 'blue' }
};

async function loadRetro() {
    const container = document.getElementById('retro-board');
    if (!container) return;
    container.innerHTML = '';

    const items = await window.api.getRetroItems();
    if (!items) return;

    ['START', 'STOP', 'CONTINUE'].forEach(type => {
        const meta = RETRO_TYPES[type];
        const filtered = items.filter(i => i.type === type);

        const col = document.createElement('div');
        col.className = 'space-y-4';
        col.innerHTML = `
            <div class="flex items-center gap-2 mb-2">
                <span class="text-lg">${meta.emoji}</span>
                <h4 class="font-semibold text-gray-200">${meta.label}</h4>
                <span class="bg-dark-700 text-xs px-2 py-0.5 rounded-md ml-auto">${filtered.length}</span>
            </div>
            ${filtered.map(item => `
                <div class="glass-card p-4 rounded-xl group">
                    <p class="text-gray-300 text-sm mb-3">${item.content}</p>
                    <div class="flex items-center justify-between">
                        <button onclick="upvoteRetro(${item.id}, this)" class="flex items-center gap-1.5 text-xs text-gray-400 hover:text-brand-400 transition-colors group/btn">
                            <svg class="w-4 h-4 group-hover/btn:scale-110 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path></svg>
                            Upvote
                        </button>
                        <span class="text-xs font-semibold text-brand-400">${item.votes} votes</span>
                    </div>
                </div>
            `).join('')}
        `;
        container.appendChild(col);
    });
}

async function upvoteRetro(id, btnEl) {
    const res = await window.api.upvoteRetroItem(id);
    if (res) {
        // Quick visual feedback
        btnEl.closest('.glass-card').classList.add('ring-1', 'ring-brand-500/50');
        setTimeout(() => loadRetro(), 300);
    }
}

function initRetroForm() {
    const form = document.getElementById('retroForm');
    if (!form) return;

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const data = {
            type: document.getElementById('retro-type').value,
            content: document.getElementById('retro-content').value,
            votes: 0
        };
        const res = await window.api.createRetroItem(data);
        if (res) {
            closeRetroModal();
            loadRetro();
        }
    });
}

function closeRetroModal() {
    const modal = document.getElementById('retroModal');
    const content = document.getElementById('retroModalContent');
    content.classList.remove('scale-100', 'opacity-100');
    content.classList.add('scale-95', 'opacity-0');
    setTimeout(() => modal.classList.add('hidden'), 300);
}

// Animate modal open
const retroObserver = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
        if (mutation.target.id === 'retroModal' && !mutation.target.classList.contains('hidden')) {
            setTimeout(() => {
                const content = document.getElementById('retroModalContent');
                content.classList.remove('scale-95', 'opacity-0');
                content.classList.add('scale-100', 'opacity-100');
            }, 10);
        }
    });
});
if (document.getElementById('retroModal')) {
    retroObserver.observe(document.getElementById('retroModal'), { attributes: true, attributeFilter: ['class'] });
}
