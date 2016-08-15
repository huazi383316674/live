[#ftl]
[@b.head/]
[@b.toolbar title="按业务类型统计(${yearMonth})"]
	var menu = bar.addItem("设置", "statSetting()");
[/@]

<script type="text/javascript" src="${base}/static/scripts/elycharts/raphael-min.js"></script>
<script type="text/javascript" src="${base}/static/scripts/elycharts/elycharts.min.js"></script>
<style>
</style>

<div id="chart" style="width: 300px; height: 300px"></div>
<div id="businessTypeBgBox" style="100%">
	<h5>
		[@b.datepicker label="年月" id="yearMonth" name="yearMonth" style="width:125px" format="yyyy-MM" value="${(yearMonth)!}" /]&nbsp;
		<input type="button" value="统计" onclick="replyStat()" />
	</h5>
</div>
[#list outlayMap?keys as key]${outlayMap[key]}[#if key_has_next],[/#if][/#list]
<script type="text/javascript">
	jQuery.elycharts.templates['pie_basic_1'] = {
  		type: "pie",
  		defaultSeries: {
    		plotProps: {
      			stroke: "white", "stroke-width": 2, opacity: 0.8
    		},
    		highlight: { move: 20 },
    		tooltip: { frameProps: { opacity: 0.5 } },
    		startAnimation: { active: false, type: "grow" } 
    	},
    	
  		features: {
    		legend: {
	      		horizontal: false,
	      		width: 40,
	      		height: 80,
	      		x: 252,
	      		y: 218,
	      		borderProps: {
	        		"fill-opacity": 0.3
	      		}
    		}
  		}
	};
	
	jQuery(function() {
		jQuery("#chart").chart({
  			template: "pie_basic_1",
		  	values: {
				serie1: [10,301,6000,65,190,17,7 ]
				
		  	},
		  	labels: ["a", "b", "c", "d",'e','f','g'],
		  	legend: ["a", "b", "c", "d",'e','f','g'],
		  	tooltips: {
		    	serie1: ["asd", "b", "c", "d",'e','f','g']
		  	},
		  	defaultSeries: {
		    	values: [{ plotProps: { fill: "red" }}, { plotProps: { fill: "blue" }}, { plotProps: { fill: "green" }}, {plotProps: { fill: "gray" }},
					{plotProps: { fill: "#a01217" }}, { plotProps: { fill: "#b1d8f6" }}, { plotProps: { fill: "#f4be19" }}, {plotProps: { fill: "#8ebb0b" }},
		    		{ plotProps: { fill: "#d64d4d" }}, { plotProps: { fill: "#0b9191" }}, {plotProps: { fill: "#914d91" }}, {plotProps: { fill: "#1791cd" }},
		    		{ plotProps: { fill: "#004276" }}, { plotProps: { fill: "#d4d0c8" }}, { plotProps: { fill: "#f9e691" }}
		    	]
		  	}
		});
	});
	
	
	function replyStat() {
		var form = document.statSettingForm;
		bg.form.submit(form);
	}
</script>
[@b.foot/]
