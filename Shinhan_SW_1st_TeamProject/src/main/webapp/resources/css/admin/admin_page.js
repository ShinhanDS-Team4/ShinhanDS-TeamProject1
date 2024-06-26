document.addEventListener('DOMContentLoaded', function() {
    var ctxVisitors = document.getElementById('visitorsChart').getContext('2d');
    var visitorsChart = new Chart(ctxVisitors, {
        type: 'line',
        data: {
            labels: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00'],
            datasets: [{
                label: 'Sales',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                data: [12, 19, 3, 5, 2, 3, 7]
            }, {
                label: 'Revenue',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                data: [2, 3, 20, 5, 1, 4, 10]
            }, {
                label: 'Customers',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                data: [3, 10, 13, 15, 22, 30, 45]
            }]
        },
        options: {}
    });

    var ctxDailyRevenue = document.getElementById('dailyRevenueChart').getContext('2d');
    var dailyRevenueChart = new Chart(ctxDailyRevenue, {
        type: 'bar',
        data: {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            datasets: [{
                label: 'Daily Revenue',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                data: [150, 200, 250, 300, 350, 400, 450]
            }]
        },
        options: {}
    });
});