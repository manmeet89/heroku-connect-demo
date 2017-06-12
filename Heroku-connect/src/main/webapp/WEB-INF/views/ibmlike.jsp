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
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/extra.css">
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
</script>
</head>
<body onload="">
            <!--div that will hold the bar chart-->
            <div class="center">
            <div class="loader" style="text-align: center; display: none"></div>
            </div>
		
		<table class="table" style="font-family: verdana">
    <thead>
      <tr>
        <th>Account</th>
        <th>Tone Analysis</th>
      </tr>
    </thead>
    <tbody>
		
			<c:forEach items="${toneAnalysis}" var="toneByAccount">
				<tr>
				
				<td style="width: 20%;color: #006193">
				<b>${toneByAccount.accountName }</b> - ${toneByAccount.meetingNoteId}
				</td>
					<td>
					<c:forEach items="${toneByAccount.toneAnalysis.documentTone.tones}" var="toneType">
		
		<c:if test="${toneType.id eq 'emotion_tone' }">
		<div class="summary--emotion">
            <h5 class="base--h5 summary--header">Emotion</h5>
            <p class="base--p summary--score-desc">
              &lt; .5 = not likely present <br> &gt; .5 = likely present <br> &gt; .75 = very likely present <br>
            </p>
            <div class="summary-emotion-graph bar-graph">
    
      <c:forEach items="${toneType.tones }" var = "tone">
      	
      	<div class="bar-graph--row summary-emotion-graph--row">
        <div class="bar-graph--label-container summary-emotion-graph--label-container">
          <div class="bar-graph--label">
            <p class="base--p">
              ${tone.name}
            </p>
            
              <div class="bar-graph--tooltip">
                <c:choose>
                	<c:when test="${tone.id eq 'anger' }">
                	Likelihood of writer being perceived as angry. Low value indicates unlikely to be perceived as angry. High value indicates very likely to be perceived as angry
                	</c:when>
                	<c:when test="${tone.id eq 'disgust' }">
                	Likelihood of writer being perceived as disgusted. Low value, unlikely to be perceived as disgusted. High value, very likely to be perceived as disgusted.
                	</c:when>
                	<c:when test="${tone.id eq 'fear' }">
                	Likelihood of writer being perceived as scared. Low value indicates unlikely to be perceived as fearful. High value, very likely to be perceived as scared.
                	</c:when>
                	<c:when test="${tone.id eq 'joy' }">
                	Joy or happiness has shades of enjoyment, satisfaction and pleasure. There is a sense of well-being, inner peace, love, safety and contentment.
                	</c:when>
                	<c:when test="${tone.id eq 'sadness' }">
                	Likelihood of writer being perceived as sad. Low value, unlikely to be perceived as sad. High value very likely to be perceived as sad.
                	</c:when>
                
                </c:choose>
              </div>
              
          </div>
        </div>
        <div class="bar-graph--bar-container summary-emotion-graph--bar-container">
          <div class="bar-graph--bar">
            <div class="bar-graph--bar-value summary-emotion-graph--bar-value summary-emotion-graph--bar-value_${tone.name}" style="width: ${100 * tone.score }%;"></div>
          </div>
        </div>
        <div class="summary-emotion-graph--percentage-label">
          ${tone.score }
            <br>
            <span class="summary-emotion-graph--percentage-label-likeliness">
            <c:choose>
            	<c:when test="${tone.score lt 0.5 }">
            		UNLIKELY
            	</c:when>
            	<c:when test="${tone.score gt 0.75 }">
            		VERY LIKELY
            	</c:when>
            	<c:otherwise>
            		LIKELY
            	</c:otherwise>
            </c:choose>
          </span>
        </div>
      </div>
      
      </c:forEach>
  </div>
          </div>
		</c:if>
		<c:if test="${toneType.id eq 'language_tone' }">
		
		<div class="summary--writing">
            <h5 class="base--h5 summary--header">Language Style</h5>
            <p class="base--p summary--score-desc">
              &lt; .5 = not likely present <br> &gt; .5 = likely present <br> &gt; .75 = very likely present <br>
            </p>
            <div class="summary-writing-graph">
    
     <c:forEach items="${toneType.tones }" var = "tone">
      <div class="bar-graph--row">
        <div class="bar-graph--label-container summary-writing-graph--label-container">
          <div class="bar-graph--label">
            <p class="base--p">
              ${tone.name }
            </p>
            
                <div class="bar-graph--tooltip">
                <c:choose>
                	<c:when test="${tone.id eq 'analytical' }">
                	A writer's reasoning and analytical attitude about things. Higher value, more likely to be perceived as intellectual, rational, systematic, emotionless, or impersonal.
                	</c:when>
                	<c:when test="${tone.id eq 'confident' }">
                	A writer's degree of certainty. Higher value, more likely to be perceived as assured, collected, hopeful, or egotistical.
                	</c:when>
                	<c:when test="${tone.id eq 'tentative' }">
                	A writer's degree of inhibition. Higher value, more likely to be perceived as questionable, doubtful, limited, or debatable.
                	</c:when>
                
                </c:choose>
              </div>
          </div>
        </div>
        <div class="bar-graph--bar-container summary-writing-graph--bar-container">
          <div class="bar-graph--bar">
            <div class="bar-graph--bar-value summary-writing-graph--bar-value summary-writing-graph--bar-value_${tone.name }" style="width: ${100 * tone.score}%;"></div>
          </div>
        </div>
        <div class="summary-writing-graph--percentage-label bar-graph--percentage-label">
          ${tone.score }
          <br>
          <span class="summary-writing-graph--percentage-label-likeliness">
            <c:choose>
            	<c:when test="${tone.score lt 0.5 }">
            		UNLIKELY
            	</c:when>
            	<c:when test="${tone.score gt 0.75 }">
            		VERY LIKELY
            	</c:when>
            	<c:otherwise>
            		LIKELY
            	</c:otherwise>
            </c:choose>
          </span>
        </div>
      </div>
      
      </c:forEach>
      
      
  </div>
          </div>
		
		
		</c:if>
		<c:if test="${toneType.id eq 'social_tone' }">
		
          <div class="summary--social">
            <h5 class="base--h5 summary--header">Social Tendencies</h5>
            <p class="base--p summary--score-desc">
              &lt; .5 = not likely present <br> &gt; .5 = likely present <br> &gt; .75 = very likely present <br>
            </p>
            <div class="summary-social-graph bar-graph">
            
            <c:forEach items="${toneType.tones }" var = "tone">
            
            <div class="bar-graph--row">
        <div class="bar-graph--label-container summary-social-graph--label-container">
          <div class="bar-graph--label">
            <p class="base--p">
              ${tone.name }
            </p>
            
              <div class="bar-graph--tooltip">
                <c:choose>
                	<c:when test="${tone.id eq 'openness_big5' }">
                	
                Higher value, writer more likely to be perceived as open to experiences for a variety of activities.
              
                	</c:when>
                	<c:when test="${tone.id eq 'conscientiousness_big5' }">
                	
                Higher value, the writer likely to be percieved as someone who would act in an organized or thoughtful way.
              
                	</c:when>
                	<c:when test="${tone.id eq 'extraversion_big5' }">
                	
                Higher value, the writer is likely to be perceived as someone who would seek stimulation in the company of others.
              
                	</c:when>
                	
                	<c:when test="${tone.id eq 'agreeableness_big5' }">
                	
                
                Higher value, writer more likely to be perceived as, compassionate and cooperative towards others.
              
              
                	</c:when>
                	
                	<c:when test="${tone.id eq 'emotional_range_big5' }">
                	
                
                Higher value, writer likely to be perceived as someone sensitive to the environment.
              
              
                	</c:when>
                
                </c:choose>
              </div>
              
          </div>
        </div>
        <div class="bar-graph--bar-container summary-social-graph--bar-container">
          <div class="bar-graph--bar">
            <div class="bar-graph--bar-value summary-social-graph--bar-value summary-social-graph--bar-value_${tone.name }" style="width: ${100 * tone.score}%;"></div>
          </div>
        </div>
        <div class="summary-social-graph--percentage-label bar-graph--percentage-label">
          ${tone.score }
          <br>
          <span class="summary-social-graph--percentage-label-likeliness">
             <c:choose>
            	<c:when test="${tone.score lt 0.5 }">
            		UNLIKELY
            	</c:when>
            	<c:when test="${tone.score gt 0.75 }">
            		VERY LIKELY
            	</c:when>
            	<c:otherwise>
            		LIKELY
            	</c:otherwise>
            </c:choose>
          </span>
        </div>
      </div>
            
            </c:forEach>
		</div>
		</div>
		</c:if>
	</c:forEach>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
</body>
</html>