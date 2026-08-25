const KANBAN_COLS = [
    { id: 'TO_DO', title: 'To Do', color: 'gray' },
    { id: 'IN_PROGRESS', title: 'In Progress', color: 'blue' },
    { id: 'REVIEW', title: 'Review', color: 'yellow' },
    { id: 'DONE', title: 'Done', color: 'green' }
];

async function loadKanban() {
    const container = document.getElementById('kanban-board');
    if (!container) return;
    container.innerHTML = '';

    KANBAN_COLS.forEach(col => {
        const colDiv = document.createElement('div');
        colDiv.className = 'kanban-column';
        colDiv.dataset.status = col.id;
        colDiv.innerHTML = `
            <div class="flex justify-between items-center mb-4">
                <h4 class="font-semibold text-gray-200">${col.title}</h4>
                <span class="bg-dark-700 text-xs px-2 py-1 rounded-md" id="count-${col.id}">0</span>
            </div>
            <div class="flex-1 space-y-3 kanban-dropzone overflow-y-auto" data-status="${col.id}"></div>
        `;
        container.appendChild(colDiv);

        const dropzone = colDiv.querySelector('.kanban-dropzone');
        dropzone.addEventListener('dragover', e => { e.preventDefault(); colDiv.classList.add('drag-over'); });
        dropzone.addEventListener('dragleave', () => colDiv.classList.remove('drag-over'));
        dropzone.addEventListener('drop', async e => {
            e.preventDefault();
            colDiv.classList.remove('drag-over');
            const cardId = e.dataTransfer.getData('text/plain');
            const card = document.getElementById(cardId);
            if (card) {
                dropzone.appendChild(card);
                updateCounts();
                const id = cardId.replace('card-', '');
                await window.api.updateStandupStatus(id, col.id);
            }
        });
    });

    const standups = await window.api.getStandups();
    if (standups) {
        standups.forEach(item => {
            const card = createCard(item);
            const dropzone = document.querySelector(`.kanban-dropzone[data-status="${item.status}"]`);
            if (dropzone) dropzone.appendChild(card);
        });
    }
    updateCounts();
}

function createCard(item) {
    const el = document.createElement('div');
    const atRiskClass = item.isAtRisk ? 'ring-2 ring-red-500/70 shadow-red-500/20 shadow-lg' : '';
    el.className = `kanban-card bg-dark-800 border border-dark-700 p-4 rounded-xl shadow-lg relative group ${atRiskClass}`;
    el.id = `card-${item.id}`;
    el.draggable = true;

    const riskBadge = item.isAtRisk
        ? `<span class="absolute top-2 right-2 text-xs bg-red-500/20 text-red-400 px-2 py-0.5 rounded-full font-medium animate-pulse">⚠ At Risk</span>`
        : '';

    el.innerHTML = `
        ${riskBadge}
        <div class="flex justify-between items-start mb-2">
            <span class="text-brand-400 font-medium text-sm">${item.teamMember}</span>
            <span class="text-xs text-gray-500">${item.date || ''}</span>
        </div>
        <p class="text-gray-300 text-sm line-clamp-2" title="${item.today}">${item.today}</p>
    `;

    el.addEventListener('dragstart', e => { el.classList.add('dragging'); e.dataTransfer.setData('text/plain', el.id); });
    el.addEventListener('dragend', () => el.classList.remove('dragging'));
    return el;
}

function updateCounts() {
    KANBAN_COLS.forEach(col => {
        const dropzone = document.querySelector(`.kanban-dropzone[data-status="${col.id}"]`);
        if (dropzone) document.getElementById(`count-${col.id}`).innerText = dropzone.children.length;
    });
}
