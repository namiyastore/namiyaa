//Flot Pie Chart
$(function() {	
	
	$.ajax({
		method : 'get',
		url : 'selectItemRanking',
		dataType : 'json',
		success : function(resp) {
			
		var data = [];
		
		if(resp == null) {
			data.push(
				{label: "Empty", data: 1}
			);
		}
		else {
			for(var i in resp) {
				data.push(
					{
						label: resp[i].productname,
						data: parseInt(resp[i].productnum)
					}
				)
			}
		}
		
		var plotObj = $.plot($("#flot-pie-chart"), data, {
	        series: {
	            pie: {
	                show: true
	            }
	        },
	        grid: {
	            hoverable: true
	        },
	        tooltip: true,
	        tooltipOpts: {
	            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
	            shifts: {
	                x: 20,
	                y: 0
	            },
	            defaultTheme: false
	        }
	    });
	
		}
	});
	
	
	
	
});
