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
