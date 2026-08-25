const BADGE_ICONS = {
    'Standup Hero': '🦸',
    'Bug Slayer': '🐛',
    'Code Ninja': '🥷',
    'Team Player': '🤝',
    'Sprint Champion': '🏆'
};

async function loadProfile() {
    const container = document.getElementById('profile-container');
    if (!container) return;

    const stats = await window.api.getUserStats('Admin');
    if (!stats) {
        container.innerHTML = '<p class="text-gray-400">Could not load profile data.</p>';
        return;
    }

    const xpForNextLevel = stats.level * 100;
    const xpProgress = ((stats.xp % 100) / 100) * 100;

    container.innerHTML = `
        <div class="glass-card p-8 rounded-3xl relative overflow-hidden">
            <!-- Glow -->
            <div class="absolute -top-10 -right-10 w-40 h-40 bg-brand-500/20 rounded-full blur-3xl"></div>

            <div class="flex items-center gap-6 mb-8">
                <img src="https://ui-avatars.com/api/?name=${stats.username}&background=8b5cf6&color=fff&size=80" class="w-20 h-20 rounded-2xl border-2 border-brand-500/50">
                <div>
                    <h3 class="text-2xl font-bold">${stats.username}</h3>
                    <p class="text-brand-400 font-medium">Level ${stats.level} · ${stats.xp} XP</p>
                </div>
                <div class="ml-auto text-right">
                    <div class="text-3xl font-bold text-orange-400">🔥 ${stats.currentStreak}</div>
                    <p class="text-xs text-gray-400">day streak</p>
                </div>
            </div>

            <!-- XP Progress Bar -->
            <div class="mb-8">
                <div class="flex justify-between text-sm mb-2">
                    <span class="text-gray-400">XP Progress</span>
                    <span class="text-brand-400">${stats.xp % 100} / 100 to Level ${stats.level + 1}</span>
                </div>
                <div class="w-full bg-dark-700 rounded-full h-3 overflow-hidden">
                    <div class="bg-gradient-to-r from-brand-500 to-purple-500 h-full rounded-full transition-all duration-1000 ease-out relative" style="width: ${xpProgress}%">
                        <div class="absolute inset-0 bg-white/20 shimmer-effect"></div>
                    </div>
                </div>
            </div>

            <!-- Badges -->
            <h4 class="text-lg font-semibold mb-4">Unlocked Badges</h4>
            <div class="grid grid-cols-2 sm:grid-cols-3 gap-4">
                ${stats.unlockedBadges.map(badge => `
                    <div class="glass-card p-4 rounded-xl text-center group hover:border-brand-500/50 transition-colors">
                        <div class="text-3xl mb-2">${BADGE_ICONS[badge] || '🏅'}</div>
                        <p class="text-sm font-medium">${badge}</p>
                    </div>
                `).join('')}
                ${stats.unlockedBadges.length === 0 ? '<p class="text-gray-500 col-span-3 text-center">No badges unlocked yet. Keep engaging!</p>' : ''}
            </div>
        </div>
    `;
}
