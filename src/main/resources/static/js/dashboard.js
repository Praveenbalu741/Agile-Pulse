function initDashboard() {
    // Velocity Doughnut Chart
    const ctx = document.getElementById('velocityChart')?.getContext('2d');
    if (ctx) {
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
                plugins: { legend: { display: false } },
                animation: { animateScale: true, animateRotate: true }
            }
        });
    }

    // Morale & Burnout Heatmap Chart
    const heatCtx = document.getElementById('heatmapChart')?.getContext('2d');
    if (heatCtx) {
        new Chart(heatCtx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
                datasets: [
                    {
                        label: 'Velocity (pts)',
                        data: [12, 19, 14, 17, 22],
                        borderColor: '#8b5cf6',
                        backgroundColor: 'rgba(139, 92, 246, 0.1)',
                        fill: true,
                        tension: 0.4,
                        yAxisID: 'y'
                    },
                    {
                        label: 'Team Morale',
                        data: [7, 6, 5, 7, 8],
                        borderColor: '#22c55e',
                        backgroundColor: 'rgba(34, 197, 94, 0.1)',
                        fill: true,
                        tension: 0.4,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: { mode: 'index', intersect: false },
                plugins: {
                    legend: { labels: { color: '#94a3b8', font: { family: 'Inter' } } }
                },
                scales: {
                    x: { ticks: { color: '#64748b' }, grid: { color: 'rgba(51, 65, 85, 0.3)' } },
                    y: {
                        type: 'linear', display: true, position: 'left',
                        title: { display: true, text: 'Velocity', color: '#8b5cf6' },
                        ticks: { color: '#8b5cf6' },
                        grid: { color: 'rgba(51, 65, 85, 0.3)' }
                    },
                    y1: {
                        type: 'linear', display: true, position: 'right',
                        title: { display: true, text: 'Morale (1-10)', color: '#22c55e' },
                        ticks: { color: '#22c55e' },
                        grid: { drawOnChartArea: false },
                        min: 0, max: 10
                    }
                }
            }
        });
    }
}
