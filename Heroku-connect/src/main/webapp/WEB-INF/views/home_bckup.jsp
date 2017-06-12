<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.7rc2.js"></script>
<style type='text/css'>
.left-text {
            text-align: left;
}

hr {
width: 100%
}

.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid blue;
  border-right: 16px solid green;
  border-bottom: 16px solid red;
  border-left: 16px solid pink;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;

}

.center {
    margin: auto;
    width: 60%;
    padding: 10px;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

</style>
<!-- import the Google charts API -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
            // load the Visualization API and the chart package
            google.load('visualization', '1.0', {'packages':['corechart']});
            // define call back handler
            //google.setOnLoadCallback(drawChart);
            
            $(document).ready(function() {
            	$(".loader").show();
            	$.getJSON( "/heroku-connect-demo/dummy", function( data ) {
            		$(".loader").hide();
            		 var items = [];
            		  $.each( data, function( key, val ) {
            			  var meetingNoteId = val['meetingNoteId'];
							var docTone = val['toneAnalysis']['documentTone']['tones'];
							$.each(docTone, function(id, tone){
								
								var data = new google.visualization.DataTable();

								data.addColumn('string', 'Emotions');
		            			data.addColumn('number', 'Score');
		            			  
								var tone1 = tone['tones'];
								$.each(tone1, function(id, tone){
									data.addRow([tone['name'], tone['score']]);	
								});
								
								/* jQuery('<div/>', {
								    id: meetingNoteId + tone['id'] + '_chart_div',
								    
								}).appendTo('.charts_container'); */
								
								//$('#' + meetingNoteId + tone['id'] + '_chart_div').css('float','left');
								
								var chart = new 
                                google.visualization.BarChart(document.getElementById(meetingNoteId + tone['id'] + '_chart_div'));
			                     // set chart options
			                     chart.draw(data, {isStacked: true,width: 500, height: 240, title: tone['name'] + ' - ' + meetingNoteId,
			                           vAxis: {titleTextStyle: {color: 'black'}},
			                           hAxis: {title: 'Score', titleTextStyle: {color: 'green'}},
			                           series: [{colors: ['blue'], visibleInLegend: true}]
			                      });
								
							});
							
							/* jQuery('<div/>', {
							    id: meetingNoteId + '_text',
							    
							}).appendTo('.charts_container');
							
							$('#' + meetingNoteId + '_text').html('<b>Account Name : </b>' + val['mootingNoteText']);
							$('#' + meetingNoteId + '_text').css('float', 'left');
							var element = document.createElement('hr');
							$(element).appendTo('.charts_container'); */
            		  });
            		 
            		  
                	console.log('<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>');  
                	console.log(data);
                	$('.charts_container').show();
                	});
            	
            });            
            
            // function to draw charts
            function drawChart() {
                        // configure Chart Details
                        var data = new google.visualization.DataTable();
                        // define columns. It will represent x axis and y axis
                        data.addColumn('string', 'Emotions');
				        data.addColumn('number', 'Score');
				        data.addRows([
				          ['Anger', 0.06],
				          ['Disgust', 0.01],
				          ['Fear', 0.01],
				          ['Joy', 0.87],
				          ['Sadness', 0.08]
				        ]);	
                        
                        var chart = new 
                                   google.visualization.BarChart(document.getElementById('emotion_chart_div'));
                        // set chart options
                        chart.draw(data, {width: 500, height: 240, title: 'Emotions Chart',
                              vAxis: {title: 'Emotions', titleTextStyle: {color: 'black'}}
                         });
                        
                        var data = new google.visualization.DataTable();
                        // define columns. It will represent x axis and y axis
                        data.addColumn('string', 'Emotions');
				        data.addColumn('number', 'Score');
				        data.addRows([
				          ['Anger', 0.06],
				          ['Disgust', 0.01],
				          ['Fear', 0.01],
				          ['Joy', 0.87],
				          ['Sadness', 0.08]
				        ]);	
                        
                        var chart = new 
                                   google.visualization.BarChart(document.getElementById('language_chart_div'));
                        // set chart options
                        chart.draw(data, {width: 500, height: 240, title: 'Language Style Chart',
                              vAxis: {title: 'Emotions', titleTextStyle: {color: 'black'}}
                         });
                        
                        
                        var data = new google.visualization.DataTable();
                        // define columns. It will represent x axis and y axis
                        data.addColumn('string', 'Emotions');
				        data.addColumn('number', 'Score');
				        data.addRows([
				          ['Anger', 0.06],
				          ['Disgust', 0.01],
				          ['Fear', 0.01],
				          ['Joy', 0.87],
				          ['Sadness', 0.08]
				        ]);	
                        
                        var chart = new 
                                   google.visualization.BarChart(document.getElementById('social_tendencies_chart_div'));
                        // set chart options
                        chart.draw(data, {width: 500, height: 240, title: 'Social Tendencies Chart',
                              vAxis: {title: 'Emotions', titleTextStyle: {color: 'black'}}
                         });
            }
</script>
</head>
<body onload="">
            <!--div that will hold the bar chart-->
            <div class="center">
            <div class="loader" style="text-align: center;"></div>
            </div>
            <div class='charts_container' style="display: none">
                        <!-- <div id="emotion_tone_chart_div" style="float:left;" ></div>
                        <div id="language_tone_chart_div" style="float:left;"></div>
                        <div id="social_tone_chart_div" style="float:left;"></div> -->

		<table>
			<c:forEach items="${notestByAccount}" var="entry">
				<tr style="font-family: verdana">
					<td>
						<p style="float: left;">
							<u>Account Name :</u> <b>${fn:split(entry.key, '-')[1]}</b>
						</p>
					</td>
				</tr>
				<tr>
					<td>
						<div id="${fn:split(entry.key, '-')[0]}emotion_tone_chart_div"
							style="float: left;width: 33%"></div>
						<div id="${fn:split(entry.key, '-')[0]}language_tone_chart_div"
							style="float: left;width: 33%"></div>
						<div id="${fn:split(entry.key, '-')[0]}social_tone_chart_div"
							style="float: left;width: 33%"></div>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>