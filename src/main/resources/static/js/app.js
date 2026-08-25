document.addEventListener('DOMContentLoaded', () => {
    const navBtns = document.querySelectorAll('.nav-btn');
    const views = document.querySelectorAll('.view-section');
    const pageTitle = document.getElementById('pageTitle');

    const VIEW_TITLES = {
        dashboard: 'Executive Dashboard',
        standup: 'Daily Standup',
        kanban: 'Sprint Board',
        retro: 'Sprint Retrospective',
        kudos: 'Pulse Stars',
        profile: 'XP & Badges',
        casestudy: 'UI/UX Case Study'
    };

    navBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            navBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const viewId = btn.getAttribute('data-view');
            pageTitle.innerText = VIEW_TITLES[viewId] || viewId;

            views.forEach(v => {
                if (v.id === `view-${viewId}`) {
                    v.classList.remove('hidden');
                    v.classList.add('active');
                } else {
                    v.classList.add('hidden');
                    v.classList.remove('active');
                }
            });

            if (viewId === 'kanban') loadKanban();
            if (viewId === 'kudos') loadKudos();
            if (viewId === 'retro') loadRetro();
            if (viewId === 'profile') loadProfile();
        });
    });

    // Initializations
    initDashboard();
    initStandupForm();
    initKudosForm();
    initRetroForm();
});
