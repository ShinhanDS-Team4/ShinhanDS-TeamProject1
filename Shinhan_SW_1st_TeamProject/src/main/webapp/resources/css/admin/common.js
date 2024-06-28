function f_search() {
	$.ajax({
		url: "search_results",
        data: {
            searchType: $("#searchType").val(),
            keyword: $("#keyword").val()
        },
        success: function(responsedata) {
            var resultsHtml = '';
            if (responsedata.length === 0) {
                resultsHtml = '<li>No results found.</li>';
            } else {
                responsedata.forEach(function(item) {
                    resultsHtml += '<li>' + item.member_name + ' (' + item.member_brand + ')</li>';
                });
            }
            $('#searchResults').html(resultsHtml);
        }
    });
}