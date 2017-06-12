<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type='text/css'>
.left-text {
            text-align: left;
}

hr {
width: 100%
}

.loader {
  position: absolute;
  left: 50%;
  top: 50%;
  z-index: 1;
  width: 150px;
  height: 150px;
  margin: -75px 0 0 -75px;
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
            	//$.getJSON( "/MeetingNotesTones", function( data ) {
            	$.getJSON( "/dummy", function( data ) {
            		$(".loader").hide();
            		 var items = [];
            		  $.each( data, function( key, val ) {
            			  var meetingNoteId = val['meetingNoteId'];
            			  var accountName = val['accountName'];
							var docTone = val['toneAnalysis']['documentTone']['tones'];
							$.each(docTone, function(id, tone){
								
								var data = new google.visualization.DataTable();

								data.addColumn('string', 'Emotions');
		            			data.addColumn('number', 'Score');
		            			  
								var tone1 = tone['tones'];
								
								var dataArray = [];
								var itemArr = [];
								itemArr.push('Element');
								itemArr.push('Score');
								itemArr.push({ role: 'style' });
								
								dataArray.push(itemArr);
								
								/* var itemArr = [];
								itemArr.push('Copper');
								itemArr.push(8.94);
								itemArr.push('#b87333');
								dataArray.push(itemArr);
								
								var itemArr = [];
								itemArr.push('Silver');
								itemArr.push(3.33);
								itemArr.push('silver');
								dataArray.push(itemArr); */
								
								$.each(tone1, function(id, tone){
									data.addRow([tone['name'], tone['score']]);	
									
									var itemArr = [];
									itemArr.push(tone['name']);
									itemArr.push(tone['score']);
									
									switch(tone['id']) {
										case 'anger' : 
											itemArr.push('#E80521');
											break;
										case 'disgust' : 
											itemArr.push('#592684');
											break;
										case 'joy' : 
											itemArr.push('#FFD629');
											break;
										case 'fear' : 
											itemArr.push('#325E2B');
											break;
										case 'sadness' : 
											itemArr.push('#086DB2');
											break;
										case 'openness_big5' : 
											itemArr.push('#1cb4a0');
											break;
										case 'conscientiousness_big5' : 
											itemArr.push('#1cb4a0');
											break;
										case 'extraversion_big5' : 
											itemArr.push('#1cb4a0');
											break;
										case 'agreeableness_big5' : 
											itemArr.push('#1cb4a0');
											break;
										case 'emotional_range_big5' : 
											itemArr.push('#1cb4a0');
											break;
										case 'analytical' : 
											itemArr.push('#274b5f');
											break;
										case 'confident' : 
											itemArr.push('#274b5f');
											break;
										case 'tentative' : 
											itemArr.push('#274b5f');
											break;
										default : 
											itemArr.push('#274b5f');
											break;
									}
																
									dataArray.push(itemArr);
								});
								
								/* jQuery('<div/>', {
								    id: meetingNoteId + tone['id'] + '_chart_div',
								    
								}).appendTo('.charts_container'); */
								
								//$('#' + meetingNoteId + tone['id'] + '_chart_div').css('float','left');
								
								/* var data = google.visualization.arrayToDataTable([
								                                                  ['Element', 'Density', { role: 'style' }],
								                                                  ['Copper', 8.94, '#b87333'],            // RGB value
								                                                  ['Silver', 10.49, 'silver'],            // English color name
								                                                  ['Gold', 19.30, 'gold'],

								                                                ['Platinum', 21.45, 'color: #e5e4e2' ], // CSS-style declaration
								                                               ]); */
								                                               
                                 var data = google.visualization.arrayToDataTable(dataArray);
								
								var chart = new 
                                google.visualization.BarChart(document.getElementById(meetingNoteId + tone['id'] + '_chart_div'));
			                     // set chart options
			                     chart.draw(data, 
			                    		 {
			                    	 legend: {position: 'none'},
			                    	   isStacked: true,
			                    	   width: 350, 
			                    	   height: 240, 
			                    	   title: tone['name'],
			                           vAxis: {titleTextStyle: {color: 'black'}},
			                           hAxis: {title: 'Score', titleTextStyle: {color: 'green', fontName: 'verdana', fontSize: 15, bold: true, italic : false}, viewWindow : {min: 0, max: 1}}
			                      });
			                     //return false;
								
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
                        chart.draw(data, {width: 800, height: 240, title: 'Social Tendencies Chart',
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

		
		
		<table class="table" style="font-family: verdana;">
    <thead>
      <tr>
        <th>Account</th>
        <th>Tone Analysis</th>
      </tr>
    </thead>
    <tbody>
		
			<c:forEach items="${notestByAccount}" var="entry">
				
				
				<%-- <tr style="font-family: verdana">
					<td>
						<p style="float: left;">
							<u>Account Name :</u> <b>${fn:split(entry.key, '-')[1]}</b>
						</p>
					</td>
				</tr> --%>
				<tr>
				<td style="width: 20%;color: #006193">
				<b>${fn:split(entry.key, '$$')[1]}</b>-${fn:split(entry.key, '$$')[0]}
				</td>
					<td>
						<div id="${fn:split(entry.key, '$$')[0]}emotion_tone_chart_div"></div>
					</td>
					<td>
						<div id="${fn:split(entry.key, '$$')[0]}language_tone_chart_div"></div>
					</td>
					<td>
						<div id="${fn:split(entry.key, '$$')[0]}social_tone_chart_div"></div>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>