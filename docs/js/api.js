// API Base fallback check: if running on GitHub Pages (static), fallback to localStorage mocks
const isStaticPages = window.location.hostname.includes('github.io') || window.location.hostname.includes('vercel.app');
const API_BASE = '/api/v1';

async function fetchAPI(endpoint, options = {}) {
    if (isStaticPages) {
        return mockFetch(endpoint, options);
    }
    try {
        const res = await fetch(`${API_BASE}${endpoint}`, {
            headers: { 'Content-Type': 'application/json' },
            ...options
        });
        if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
        return await res.json();
    } catch (error) {
        console.error('API Error:', error);
        return mockFetch(endpoint, options);
    }
}

// LocalStorage Mock engine for offline/static deployment
function mockFetch(endpoint, options) {
    const getStorage = (key, defaultVal) => JSON.parse(localStorage.getItem(key)) || defaultVal;
    const setStorage = (key, val) => localStorage.setItem(key, JSON.stringify(val));

    // Seed initial mock data if empty
    if (!localStorage.getItem('ap_standups')) {
        setStorage('ap_standups', [
            { id: 1, teamMember: 'Alice', yesterday: 'Worked on auth API', today: 'Review PRs', blockers: 'None', status: 'TO_DO', date: '2026-08-25', sentimentScore: 0.8, isAtRisk: false },
            { id: 2, teamMember: 'Bob', yesterday: 'Fixed CSS bugs', today: 'Implementing drag and drop', blockers: 'Stuck on a severe blocker, feeling burnout', status: 'IN_PROGRESS', date: '2026-08-25', sentimentScore: -0.9, isAtRisk: true }
        ]);
    }
    if (!localStorage.getItem('ap_kudos')) {
        setStorage('ap_kudos', [
            { id: 1, sender: 'Alice', receiver: 'Bob', message: 'Great job on the CSS fixes!' }
        ]);
    }
    if (!localStorage.getItem('ap_retro')) {
        setStorage('ap_retro', [
            { id: 1, type: 'START', content: 'More pair programming', votes: 3 },
            { id: 2, type: 'STOP', content: 'Merging PRs without review', votes: 5 },
            { id: 3, type: 'CONTINUE', content: 'Weekly tech talks', votes: 8 }
        ]);
    }
    if (!localStorage.getItem('ap_stats')) {
        setStorage('ap_stats', { username: 'Admin', xp: 350, level: 4, currentStreak: 5, unlockedBadges: ['Standup Hero', 'Bug Slayer'] });
    }

    if (endpoint === '/standups') {
        if (options.method === 'POST') {
            const list = getStorage('ap_standups', []);
            const newItem = JSON.parse(options.body);
            newItem.id = Date.now();
            // Static analysis check
            const combinedText = (newItem.yesterday + " " + newItem.today + " " + newItem.blockers).toLowerCase();
            const negativeKeywords = ["blocker", "stuck", "burnout", "overwhelmed", "failing", "blocked", "issue"];
            let negativeHits = negativeKeywords.filter(word => combinedText.includes(word)).length;
            newItem.sentimentScore = negativeHits === 0 ? 0.8 : (negativeHits === 1 ? -0.2 : -0.9);
            newItem.isAtRisk = newItem.sentimentScore < -0.5;
            list.push(newItem);
            setStorage('ap_standups', list);
            
            // Add XP
            const stats = getStorage('ap_stats');
            stats.xp += 20;
            stats.level = Math.floor(stats.xp / 100) + 1;
            if (stats.level >= 2 && !stats.unlockedBadges.includes('Standup Hero')) {
                stats.unlockedBadges.push('Standup Hero');
            }
            setStorage('ap_stats', stats);
            
            return Promise.resolve(newItem);
        }
        return Promise.resolve(getStorage('ap_standups', []));
    }

    if (endpoint.startsWith('/standups/') && endpoint.endsWith('/status')) {
        const id = parseInt(endpoint.split('/')[2]);
        const status = JSON.parse(options.body).status;
        const list = getStorage('ap_standups', []);
        const item = list.find(x => x.id === id);
        if (item) {
            item.status = status;
            setStorage('ap_standups', list);
        }
        return Promise.resolve(item);
    }

    if (endpoint === '/kudos') {
        if (options.method === 'POST') {
            const list = getStorage('ap_kudos', []);
            const newItem = JSON.parse(options.body);
            newItem.id = Date.now();
            list.push(newItem);
            setStorage('ap_kudos', list);
            
            // Add XP
            const stats = getStorage('ap_stats');
            stats.xp += 50;
            stats.level = Math.floor(stats.xp / 100) + 1;
            setStorage('ap_stats', stats);
            
            return Promise.resolve(newItem);
        }
        return Promise.resolve(getStorage('ap_kudos', []));
    }

    if (endpoint === '/retro') {
        if (options.method === 'POST') {
            const list = getStorage('ap_retro', []);
            const newItem = JSON.parse(options.body);
            newItem.id = Date.now();
            list.push(newItem);
            setStorage('ap_retro', list);
            return Promise.resolve(newItem);
        }
        return Promise.resolve(getStorage('ap_retro', []));
    }

    if (endpoint.startsWith('/retro/') && endpoint.endsWith('/upvote')) {
        const id = parseInt(endpoint.split('/')[2]);
        const list = getStorage('ap_retro', []);
        const item = list.find(x => x.id === id);
        if (item) {
            item.votes += 1;
            setStorage('ap_retro', list);
        }
        return Promise.resolve(item);
    }

    if (endpoint.startsWith('/users/')) {
        return Promise.resolve(getStorage('ap_stats'));
    }
}

window.api = {
    getStandups: () => fetchAPI('/standups'),
    createStandup: (data) => fetchAPI('/standups', { method: 'POST', body: JSON.stringify(data) }),
    updateStandupStatus: (id, status) => fetchAPI(`/standups/${id}/status`, { method: 'PATCH', body: JSON.stringify({ status }) }),
    getKudos: () => fetchAPI('/kudos'),
    createKudo: (data) => fetchAPI('/kudos', { method: 'POST', body: JSON.stringify(data) }),
    getRetroItems: () => fetchAPI('/retro'),
    createRetroItem: (data) => fetchAPI('/retro', { method: 'POST', body: JSON.stringify(data) }),
    upvoteRetroItem: (id) => fetchAPI(`/retro/${id}/upvote`, { method: 'POST' }),
    getUserStats: (username) => fetchAPI(`/users/${username}/stats`)
};
