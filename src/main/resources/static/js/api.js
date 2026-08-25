const API_BASE = '/api/v1';

async function fetchAPI(endpoint, options = {}) {
    try {
        const res = await fetch(`${API_BASE}${endpoint}`, {
            headers: { 'Content-Type': 'application/json' },
            ...options
        });
        if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
        return await res.json();
    } catch (error) {
        console.error('API Error:', error);
        return null;
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
