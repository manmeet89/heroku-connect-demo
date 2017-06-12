<!DOCTYPE html>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <html lang="en">

            <head>
                <title>Admin</title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
                <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

                <style type="text/css">
                    /* The switch - the box around the slider */
                    
                    .switch {
                        position: relative;
                        display: inline-block;
                        width: 60px;
                        height: 34px;
                    }
                    /* Hide default HTML checkbox */
                    
                    .switch input {
                        display: none;
                    }
                    /* The slider */
                    
                    .slider {
                        position: absolute;
                        cursor: pointer;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background-color: #ccc;
                        -webkit-transition: .4s;
                        transition: .4s;
                    }
                    .slider:before {
                        position: absolute;
                        content: "";
                        height: 26px;
                        width: 26px;
                        left: 4px;
                        bottom: 4px;
                        background-color: white;
                        -webkit-transition: .4s;
                        transition: .4s;
                    }
                    input:checked + .slider {
                        background-color: #2196F3;
                    }
                    input:focus + .slider {
                        box-shadow: 0 0 1px #2196F3;
                    }
                    input:checked + .slider:before {
                        -webkit-transform: translateX(26px);
                        -ms-transform: translateX(26px);
                        transform: translateX(26px);
                    }
                    /* Rounded sliders */
                    
                    .slider.round {
                        border-radius: 34px;
                    }
                    .slider.round:before {
                        border-radius: 50%;
                    }
                </style>

                <script type="text/javascript">
                    $(document).ready(function() {
                    	
                    	var tabName = '${param.tab}';
                    	switch(tabName) {
			                    	case 'config' : 
                   						$('.configTab').trigger('click');
                   						break;
			                    	case 'subscriber' : 
                						$('.subscriberTab').trigger('click');
                						break;
			                    	case 'publisher' : 
                						$('.publisherTab').trigger('click');
                						break;
			                    	case 'cache' : 
                						$('.cacheTab').trigger('click');
                						break;
                    	}

                        $('#successParam').fadeOut(3000);


                        if ($('#successMsgBox').text() != "") {
                            $('#successMsgBox').delay(1000).fadeOut(3000);
                        }

                        if ($('#errMsgBox').text() != "") {}
                        
                        
                        $('.clearConfigcacheBtn').click(function() {
                        	if(confirm('Are you sure you want to clear cache ?')) {
                        		
                        		$.get( "/admin/clearConfigCache", function( data ) {
                        			  $('#successCacheClear').fadeIn(3000);
                        			  $('#successCacheClear').fadeOut(3000);
                        			});
                        		
                        	}
                        });
                        
                        $('.editBtn').click(function() {
                        	$(this).closest('tr').find('select').prop('disabled', false);
                        	$(this).closest('tr').find('input').prop('disabled', false);
                        	
                        });
                        $('.saveBtn').click(function() {
                        	$(this).closest('tr').find('select').prop('disabled', true);
                        	$(this).closest('tr').find('input').prop('disabled', true);
                        	
                        });
                        
                        $('.addDatasetBtn').click(function() {
                        	$(this).parents('table').find('.hiddenSubscriberDatasetTr').show();
                        });
                        
                        $('.cancelAddDataset').click(function() {
                        	$(this).parents('table').find('.hiddenSubscriberDatasetTr').hide();
                        });
                        
                        $('.addSubscriberBtn').click(function() {
                        	$('.hiddenSubscriberTable').show();
                        });
                        
                        $('.cancelAddSubscriberBtn').click(function() {
                        	$('.hiddenSubscriberTable').hide();
                        });
                        
                        
                        $('.allowDatasetBtn').click(function() {
                        	$(this).parents('table').find('.hiddenPublisherDatasetTr').show();
                        });
                        
                        $('.cancelAllowDataset').click(function() {
                        	$(this).parents('table').find('.hiddenPublisherDatasetTr').hide();
                        });
                        
                        $('.addPublisherBtn').click(function() {
                        	$('.hiddenPublisherTable').show();
                        });
                        
                        $('.cancelAddPublisherBtn').click(function() {
                        	$('.hiddenPublisherTable').hide();
                        });
                        
                        $('.savePublisherBtn').click(function() {
            				var myObj = new Object();
            	        	myObj.publisherIDPUser = $('.addPublisherName').val();
            	        	myObj.status = $('.addPublisherStatus').val();
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/addPublisher",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Publisher saved successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=publisher';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.savePublisherDatasetBtn').click(function() {
            				var myObj = new Object();
            	        	myObj.publisherIDPUser = $(this).parents('.publisherTable').find('.hiddenPublisherName').val();
            	        	myObj.dataSetName = $(this).parents('.hiddenPublisherDatasetTr').find('.datasetName').val();
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/addPublisherDataset",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Dataset added successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=publisher';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.deletePublisherDatasetBtn').click(function() {
                        	if(confirm('Are you sure you want to remove allowed dataset ?')) {
                        		var myObj = new Object();
                	        	myObj.publisherIDPUser = $(this).parents('.publisherTable').find('.hiddenPublisherName').val();
                	        	myObj.dataSetName = $(this).parents('.datasetTr').find('.datasetName').html();
                	        	$.ajax({
                	        		  type: "POST",
                	        		  url: "${pageContext.request.contextPath}/admin/deletePublisherDataset",
                	        		  contentType: "application/json",
                					  data : JSON.stringify(myObj),
                	        		  success :function(data) {
                	        			  if(data == 'success') {
                	        				  alert('Dataset deleted successfully!')
                	        			  }else {
                	        				  alert('Some error occurred!')
                	        			  }
                	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=publisher';
                	        		  } 
                	        		  });
                        	}
            	        });
                        
                        $('.deleteSubscriberDatasetBtn').click(function() {
                        	if(confirm('Are you sure you want to remove subscribed dataset ?')) {
                        		var myObj = new Object();
                	        	myObj.subscriberName = $(this).parents('.subscriberTable').find('.hiddenSubscriberName').val();
                	        	myObj.dataSetName = $(this).parents('.subscriberDatasetTr').find('.datasetName').html();
                	        	$.ajax({
                	        		  type: "POST",
                	        		  url: "${pageContext.request.contextPath}/admin/deleteSubscriberDataset",
                	        		  contentType: "application/json",
                					  data : JSON.stringify(myObj),
                	        		  success :function(data) {
                	        			  if(data == 'success') {
                	        				  alert('Dataset deleted successfully!')
                	        			  }else {
                	        				  alert('Some error occurred!')
                	        			  }
                	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=subscriber';
                	        		  } 
                	        		  });
                        	}
            	        });
                        
                        $('.updatePublisherStatus').click(function() {
            				var myObj = new Object();
            				myObj.publisherIDPUser = $(this).parents('.publisherTable').find('.hiddenPublisherName').val();
            	        	myObj.status = $(this).parents('.publisherTr').find('.publisherStatus').val();
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/updatePublisherStatus",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Publisher status updated successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=publisher';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.updateSubscriberStatusBtn').click(function() {
            				var myObj = new Object();
            				myObj.subscriberName = $(this).parents('.subscriberTable').find('.hiddenSubscriberName').val();
            	        	myObj.status = $(this).parents('.subscriberTr').find('.subscriberStatus').val();
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/updateSubscriberStatus",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Subscriber status updated successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=subscriber';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.saveSubscriberBtn').click(function() {
            				var myObj = new Object();
            				myObj.subscriberName = $(this).parents('.hiddenSubscriberTable').find('.addSubscriberName').val();
            	        	myObj.status = $(this).parents('.hiddenSubscriberTable').find('.addSubscriberStatus').val();
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/addSubscriber",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Subscriber added successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=subscriber';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.saveSubscriberDatasetBtn').click(function() {
            				var myObj = new Object();
            				myObj.subscriberName = $(this).parents('.subscriberTable').find('.hiddenSubscriberName').val();
            	        	myObj.dataSetName = $(this).parents('.hiddenSubscriberDatasetTr').find('.datasetName').val();
            	        	myObj.endPointURL = $(this).parents('.hiddenSubscriberDatasetTr').find('.endpointUrl').val();
            	        	myObj.authType = $(this).parents('.hiddenSubscriberDatasetTr').find('.authType').val();
            	        	myObj.token = $(this).parents('.hiddenSubscriberDatasetTr').find('.token').val();
            	        	
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/addSubscriberDataset",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Dataset added successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=subscriber';
            	        		  } 
            	        		  });
            	        });
                        
                        $('.updateSubscriberDatasetBtn').click(function() {
            				var myObj = new Object();
            				myObj.subscriberName = $(this).parents('.subscriberTable').find('.hiddenSubscriberName').val();
            				myObj.dataSetName = $(this).parents('.subscriberDatasetTr').find('.datasetName').html();
            	        	myObj.endPointURL = $(this).parents('.subscriberDatasetTr').find('.endpointUrl').val();
            	        	myObj.authType = $(this).parents('.subscriberDatasetTr').find('.authType').val();
            	        	myObj.token = $(this).parents('.subscriberDatasetTr').find('.token').val();
            	        	
            	        	$.ajax({
            	        		  type: "POST",
            	        		  url: "${pageContext.request.contextPath}/admin/updateSubscriberDataset",
            	        		  contentType: "application/json",
            					  data : JSON.stringify(myObj),
            	        		  success :function(data) {
            	        			  if(data == 'success') {
            	        				  alert('Dataset updated successfully!')
            	        			  }else {
            	        				  alert('Some error occurred!')
            	        			  }
            	        			  window.location.href = '${pageContext.request.contextPath}/admin?tab=subscriber';
            	        		  } 
            	        		  });
            	        });
                        
                        
                    });

                    function formSubmit() {
                        document.getElementById("logoutForm").submit();
                    }
                </script>
            </head>
            <body>
                <sec:authorize access="hasRole('ROLE_USER')">
                    <c:url value="/logout" var="logoutUrl" />
                    <form action="${logoutUrl}" method="post" id="logoutForm">
                    </form>
                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                        <div style="float: right; padding-right: 20px">
                            <h3>
					<b>${pageContext.request.userPrincipal.name}</b> | <a
						href="javascript:formSubmit()"> Logout</a>
				</h3>
                        </div>
                    </c:if>

                    <div class="container">
                        <h3>Application Administration</h3>
                        <div>
                            <c:if test="${not empty paramsUpdated}">
                                <c:choose>
                                    <c:when test="${paramsUpdated eq 'error'}">
                                        <div id="errorParam" class="alert alert-danger">
                                            <strong>Error!</strong> Some error occurred while updating parameters.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div id="successParam" class="alert alert-success">
                                            <strong>Success!</strong> Parameters updated successfully..
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </div>
                        
                        <div id="successCacheClear" class="alert alert-success" style="display: none;">
                                            <strong>Success!</strong> Cache cleared successfully!!
                                        </div>
                        <c:if test="${not empty error}">
                            <c:choose>
                                <c:when test="${error}">
                                    <div id="errMsgBox" class="alert alert-danger">
                                        <strong>Error!</strong> ${msg}.
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:if>

                        <div class="tabs" style="width: 100%;">
                            <ul class="nav nav-tabs">
                                <li class="active"><a class="configTab" data-toggle="tab" href="#tab1"><b>Manage Config Params
							</b></a>
                                </li>
                                <li><a data-toggle="tab" class="publisherTab" href="#tab2"><b>Manage Publishers
							</b></a>
                                </li>
                                <li><a data-toggle="tab" class="subscriberTab" href="#tab3"><b>Manage Subscribers
							</b></a>
                                </li>
                                
                                <li><a data-toggle="tab" class="cacheTab" href="#tab4"><b>Clear Cache
							</b></a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div id="tab1" class="tab-pane fade in active">
                                
                                    <h3>Configuration Parameters</h3>
                                    <p>This tab will allow you to update the configuration parameters defined in the application.</p>
                                    <fieldset>

                                        <form:form method="POST" action="${pageContext.request.contextPath}/admin/updateConfigParams" commandName="configForm">
                                            <table class="tab1 table">
                                                <tr style="background: lightblue;">
                                                    <th><b>Name</b>
                                                    </th>
                                                    <th><b>Value</b>
                                                    </th>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <label for="emailTo">Email To</label>
                                                    </td>
                                                    <td>

                                                        <form:input path="emailTo" type="text" class="form-control" id="emailTo" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="emailFrom">Email From</label>
                                                    </td>
                                                    <td>
                                                        <form:input path="emailFrom" type="text" class="form-control" id="emailFrom" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="emailFromName">Email From Name</label>
                                                    </td>
                                                    <td>
                                                        <form:input path="emailFromName" type="text" class="form-control" id="emailFromName" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="archiveDataCron">Archive Data Cron</label>
                                                        <a>(http://www.cronmaker.com/)</a>
                                                    </td>
                                                    <td>
                                                        <form:input path="archiveDataCron" type="text" class="form-control" id="archiveDataCron" />
                                                    </td>

                                                </tr>
                                                <tr>

                                                    <td>
                                                        <label for="archiveDataJobStatus">Archive Data Job Status</label>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <form:select path="archiveDataJobStatus" cssClass="form-control">
                                                                <form:option value="ACTIVE"></form:option>
                                                                <form:option value="INACTIVE"></form:option>
                                                            </form:select>
                                                        </div>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="sendErrorEmail">Send Error Notification Email</label>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <form:select path="sendErrorEmail" cssClass="form-control">
                                                                <form:option value="TRUE"></form:option>
                                                                <form:option value="FALSE"></form:option>
                                                            </form:select>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label for="sendGridTemplateId">Send Grid Template Id</label>
                                                    </td>
                                                    <td>
                                                        <form:input path="sendGridTemplateId" type="text" class="form-control" id="sendGridTemplateId" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <!--############ Spring security required for POST a form data ################-->
                                                    <!--############ Spring security required for POST a form data ################-->
                                                    <th colspan="3" style="text-align: center; border-radius: 10px;">
                                                        <input class="btn btn-primary btn-lg btn-block loginBtn" type="submit" onclick="javascript:void()" value="Submit" style="border-radius: 5px; width: auto;" />
                                                    </th>
                                                </tr>
                                            </table>
                                        </form:form>
                                    </fieldset>
                                </div>
                                <div id="tab3" class="tab-pane fade">
                                    <h3>Subscribers</h3>
                                    <p>This tab will allow you to manage the subscribers subscribed to the application for any data set.</p>
                                    <fieldset>

                                        <form method="POST" action="${pageContext.request.contextPath}/admin/updateConfigParams" commandName="configForm">
                                            
                                            <c:forEach items="${subscribers}" var="subscriber">
                                                <table class="tab1 table subscriberTable">
                                                <input type="hidden" class="hiddenSubscriberName" value="${subscriber.subscriberName}"></input>
                                                <tr style="background: lightblue;">
                                                    <th style="width: 10%"><b>Name</b>
                                                    </th>
                                                    <th style="width: 20%"><b>Status</b>
                                                    </th>
                                                    <th style="width: 70%"><b>Action</b>
                                                    </th>
                                                </tr>
                                                
                                                
                                                
                                                <tr class="subscriberTr">

                                                    <td>
                                                        <label for="archiveDataJobStatus">${subscriber.subscriberName }</label>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <select class="form-control subscriberStatus" disabled="disabled" >
                                                                <option value="ACTIVE" ${subscriber.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                                                                <option value="INACTIVE" ${subscriber.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                                                            </select>
                                                        </div>

                                                    </td>
                                                    
                                                    <td>
                                                    <button type="button" class="btn btn-default editBtn">Edit</button>
                                                    <button type="button" class="btn btn-default updateSubscriberStatusBtn">Save</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                <td colspan="3" align="center">
                                                <h4>Subscribed Datasets</h4>
                                                </td>
                                                </tr>
                                                <tr>
                                                <td colspan="3">
                                                <table class="tab1 table subscriberDatasetTable">
                                                    <tr style="background: lightgreen;">
                                                    <th><b>Dataset</b>
                                                    </th>
                                                    <th><b>Endpoint</b>
                                                    </th>
                                                    <th><b>Authorisation Type</b>
                                                    </th>
                                                     <th><b>Token</b>
                                                    </th>
                                                    <th><b>Action</b>
                                                    </th>
                                                </tr>
                                                
                                                <c:if test="${fn:length(subscriber.subscriberDataSets) eq 0}">
                                                	<tr class="datasetTr">
                                                	<td colspan="5" style="text-align: center;">
                                                	<label>No Datasets Subscribed ! </label>
                                                	</td>
                                                	</tr>
                                                </c:if>
											<c:forEach items="${subscriber.subscriberDataSets }" var="subscriberDataset">
												<tr class="subscriberDatasetTr">
													<td><label class="datasetName">${subscriberDataset.dataSetName }</label>
													</td>
													<td><input type="text" disabled="disabled"
														class="form-control endpointUrl" id="emailTo" value="${subscriberDataset.endPointURL }" /></td>
													<td>
														<div class="form-group">
															<select class="form-control authType" disabled="disabled">
															<option value="IDP" ${subscriberDataset.authType == 'IDP' ? 'selected' : ''}>IDP</option>
															<option value="Layer7" ${subscriberDataset.authType == 'Layer7' ? 'selected' : ''}>Layer7</option>
															</select>
														</div>

													</td>
													<td><input type="text" disabled="disabled"
														class="form-control token" id="emailTo" value="${subscriberDataset.token }" /></td>
														<td>
                                                    <button type="button" class="btn btn-default editBtn">Edit</button>
                                                    <button type="button" class="btn btn-default deleteSubscriberDatasetBtn">Delete</button>
                                                    <button type="button" class="btn btn-default updateSubscriberDatasetBtn">Save</button>
                                                    </td>


												</tr>
												
												
												</c:forEach>
												
												<tr class="hiddenSubscriberDatasetTr" style="display: none;">
													<td>
													
													<div class="form-group">
															<select class="form-control datasetName">
																<c:forEach items="${masterDatasets}" var="dataset">
																	<option value="${dataset.datasetName }">${dataset.datasetName }</option>
																</c:forEach>
															</select>
														</div>
													
													</td>
													<td><input  type="text"
														class="form-control endpointUrl" id="emailTo" value="" /></td>
													<td>
														<div class="form-group">
															<select class="form-control authType">
															<option value="IDP">IDP</option>
															<option value="Layer7">Layer7</option>
															</select>
														</div>

													</td>
													<td><input type="text"
														class="form-control token" id="emailTo" /></td>
														<td>
                                                    <button type="button" class="btn btn-default saveSubscriberDatasetBtn">Save</button>
                                                    <button type="button" class="btn btn-default cancelAddDataset">Cancel</button>
                                                    </td>


												</tr>
												
												
												<tr>
												
												<td colspan="5" align="right">
                                                        <input class="btn btn-primary btn-lg btn-block addDatasetBtn" type="button" onclick="javascript:void()" value="Add Dataset" style="border-radius: 5px; width: auto;" />
												</td>
												
												</tr>

											</table>
                                                </td>
                                                
                                                </tr>
                                                
                                                </table>
                                                <hr style="border: solid;">
                                            </c:forEach>
                                            
                                                        
                                                        
                                                        
                                                        <table class="tab1 table hiddenSubscriberTable" style="display: none;">
                                                <tr style="background: lightblue;">
                                                    <th><b>Name</b>
                                                    </th>
                                                    <th><b>Status</b>
                                                    </th>
                                                    <th><b>Action</b>
                                                    </th>
                                                </tr>
                                                
                                                
                                                
                                                <tr class="subscriberTr">

                                                    <td>
                                                        <input type="text"
														class="form-control addSubscriberName" value="" />
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <select class="form-control addSubscriberStatus" >
                                                                <option value="ACTIVE" >ACTIVE</option>
                                                                <option value="INACTIVE" >INACTIVE</option>
                                                            </select>
                                                        </div>

                                                    </td>
                                                    
                                                    <td>
                                                    <button type="button" class="btn btn-default saveSubscriberBtn">Save</button>
                                                    <button type="button" class="btn btn-default cancelAddSubscriberBtn">Cancel</button>
                                                    </td>
                                                </tr>
                                                </table>
                                                
                                                <input class="btn btn-primary btn-lg btn-block addSubscriberBtn" type="button" value="Add Subscriber" style="border-radius: 5px; width: auto;" />
                                                
                                                
                                       </form>
                                    </fieldset>
                                </div>
                                <div id="tab2" class="tab-pane fade">
                                    <h3>Publishers</h3>
                                    <p>This tab will allow you to manage publishers publishing data to the application.</p>
                                    
                                    
                                    
                                    
                                    <fieldset>

                                        <form method="POST" action="${pageContext.request.contextPath}/admin/updateConfigParams" commandName="configForm">
                                            
                                            <c:forEach items="${publishers}" var="publisher">
                                                <table class="tab1 table publisherTable">
                                                <input type="hidden" class="hiddenPublisherName" value="${publisher.publisherIDPUser}"></input>
                                                <tr style="background: lightblue;">
                                                    <th style="width: 10%"><b>Name</b>
                                                    </th>
                                                    <th style="width: 20%"><b>Status</b>
                                                    </th>
                                                    <th style="width: 70%"><b>Action</b>
                                                    </th>
                                                </tr>
                                                
                                                
                                                
                                                <tr class="publisherTr">

                                                    <td>
                                                        <label for="archiveDataJobStatus">${publisher.publisherIDPUser }</label>
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <select class="form-control publisherStatus" disabled="disabled" >
                                                                <option value="ACTIVE" ${publisher.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                                                                <option value="INACTIVE" ${publisher.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                                                            </select>
                                                        </div>

                                                    </td>
                                                    
                                                    <td>
                                                    <button type="button" class="btn btn-default editBtn">Edit</button>
                                                    <button type="button" class="btn btn-default updatePublisherStatus">Save</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                <td colspan="3" align="center">
                                                <h4>Allowed Datasets</h4>
                                                </td>
                                                </tr>
                                                <tr>
                                                <td colspan="3">
                                                <table class="tab1 table publisherDatasetTable">
                                                    <tr style="background: lightgreen;">
                                                    <th style="width: 20%"><b>Dataset</b>
                                                    </th>
                                                   
                                                    <th><b>Action</b>
                                                    </th>
                                                </tr>
                                                <c:if test="${fn:length(publisher.publisherDataSets) eq 0}">
                                                	<tr class="datasetTr">
                                                	<td colspan="2" style="text-align: center;">
                                                	<label>No Datasets ! </label>
                                                	</td>
                                                	</tr>
                                                </c:if>
											<c:forEach items="${publisher.publisherDataSets }" var="publisherDataset">
												<tr class="datasetTr">
													<td><label for="archiveDataJobStatus" class="datasetName">${publisherDataset.dataSetName }</label>
													</td>
													
														<td>
                                                    <button type="button" class="btn btn-default deletePublisherDatasetBtn">Delete</button>
                                                    </td>
												</tr>
												</c:forEach>
												
												<tr class="hiddenPublisherDatasetTr" style="display: none;">
													<td>
													
													<div class="form-group">
															<select class="form-control datasetName">
															<c:forEach items="${masterDatasets}" var="dataset">
																	<option value="${dataset.datasetName }">${dataset.datasetName }</option>
																</c:forEach>
															</select>
														</div>
													
													</td>
													
														<td>
                                                    <button type="button" class="btn btn-default savePublisherDatasetBtn">Save</button>
                                                    <button type="button" class="btn btn-default cancelAllowDataset">Cancel</button>
                                                    </td>


												</tr>
												
												
												<tr>
												
												<td colspan="5" align="right">
                                                        <input class="btn btn-primary btn-lg btn-block allowDatasetBtn" type="button" onclick="javascript:void()" value="Add Dataset" style="border-radius: 5px; width: auto;" />
												</td>
												
												</tr>

											</table>
                                                </td>
                                                
                                                </tr>
                                                
                                                </table>
                                                <hr style="border: solid;">
                                            </c:forEach>
                                            
                                                        
                                                        
                                                        
                                                        <table class="tab1 table hiddenPublisherTable" style="display: none;">
                                                
                                                <tr style="background: lightblue;">
                                                    <th><b>Name</b>
                                                    </th>
                                                    <th><b>Status</b>
                                                    </th>
                                                    <th><b>Action</b>
                                                    </th>
                                                </tr>
                                                
                                                
                                                
                                                <tr class="publisherTr">

                                                    <td>
                                                        <input type="text"
														class="form-control addPublisherName" value="" />
                                                    </td>
                                                    <td>
                                                        <div class="form-group">
                                                            <select class="form-control addPublisherStatus" >
                                                                <option value="ACTIVE" >ACTIVE</option>
                                                                <option value="INACTIVE" >INACTIVE</option>
                                                            </select>
                                                        </div>

                                                    </td>
                                                    
                                                    <td>
                                                    <button type="button" class="btn btn-default savePublisherBtn">Save</button>
                                                    <button type="button" class="btn btn-default cancelAddPublisherBtn">Cancel</button>
                                                    </td>
                                                </tr>
                                                </table>
                                                
                                                <input class="btn btn-primary btn-lg btn-block addPublisherBtn" type="button" value="Add Publisher" style="border-radius: 5px; width: auto;" />
                                                
                                                
                                       </form>
                                    </fieldset>
                                </div>
                                
                                <div id="tab4" class="tab-pane fade">
                                    <h3>Clear Cache</h3>
                                    <p>This tab will allow you to clear the caches in the Application.</p>
                                    
                                    <button type="button" class="clearConfigcacheBtn btn btn-primary">Clear Config Param Cache</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </sec:authorize>
            </body>
            </html>