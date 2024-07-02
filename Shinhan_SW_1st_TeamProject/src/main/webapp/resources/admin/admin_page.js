document.addEventListener('DOMContentLoaded', function() {
	var ctxVisitors = document.getElementById('visitorsChart').getContext('2d');
	var last_day = new Date(2024, 12, 0).getDate();
	var labels = [];
	for(let i=1; i<=last_day; i++){
	   labels.push(i);
	}
	
    var visitorsChart = new Chart(ctxVisitors, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Sales',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                data: 
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
    
        var daysInMonth = new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0).getDate();
    var labels = Array.from({length: daysInMonth}, (v, k) => (k + 1).toString());

    function getVisitorCounts(data) {
        var counts = Array(daysInMonth).fill(0);
        data.forEach(function(item) {
            var day = parseInt(item.DAY.split('-')[2], 10);
            counts[day - 1] = item.VISITOR_COUNT;
        });
        return counts;
    }

    var ctxVisitors = document.getElementById('visitorsChart').getContext('2d');
    var visitorsChart = new Chart(ctxVisitors, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Visitors (Sellers)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                data: getVisitorCounts(dailyVisitorDataForSellers)
            }, {
                label: 'Visitors (Customers)',
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                data: getVisitorCounts(dailyVisitorDataForCustomers)
            }]
        },
        options: {}
    });

    var ctxDailyRevenue = document.getElementById('dailyRevenueChart').getContext('2d');
    var dailyRevenueChart = new Chart(ctxDailyRevenue, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Daily Revenue',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                data: dailyRevenueData // 일일 수익 데이터
            }]
        },
        options: {}
    });
    
    
});