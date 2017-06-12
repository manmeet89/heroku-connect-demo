/**
 *
 */
package heroku.connect.demo.service;

import java.util.ArrayList;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import heroku.connect.demo.GenericDAO;

/**
 * @author ManmeetFIL
 *
 */
@Service
public class DataLoadService {

	@Autowired
	GenericDAO genericDAO;

	String herokuURL = "https://crm-databus-dev.herokuapp.com/api/publishData";

	String idpUserName = "WHOLESALECEUAT";

	String idpPassword = "password";

	String idpURL = "https://crm-idp-prod.herokuapp.com/authenticate";

	public void dataLoad(String object, Long limit) {
		while (true) {
			JSONObject layer7JSON = new JSONObject();
			JSONArray dataArray = new JSONArray();
			Map<String, Map<String, String>> result = genericDAO.getSFDataFromHerokuConnect(object, limit);
			if (result.keySet().size() == 0) {
				break;
			}
			for (String recordId : result.keySet()) {
				JSONObject recordJSON = new JSONObject();
				recordJSON.put("recordId", recordId);
				recordJSON.put("objectName", object);
				recordJSON.put("objectLabel", object);
				recordJSON.put("operation", "Insert");
				JSONArray fieldsJSONArray = new JSONArray();
				Map<String, String> fieldsMap = result.get(recordId);
				for (String field : fieldsMap.keySet()) {
					JSONObject fieldObj = new JSONObject();
					String fieldName = field.split("--")[0];
					String fieldType = field.split("--")[1];
					if ("id".equalsIgnoreCase(fieldName)) {
						continue;
					}
					fieldObj.put("newValue", fieldsMap.get(field));
					fieldObj.put("oldValue", "");
					fieldObj.put("fieldName", fieldName.toUpperCase());
					fieldObj.put("fieldLabel", fieldName.toUpperCase());
					fieldObj.put("changeById", fieldsMap.get("lastmodifiedbyid"));
					fieldObj.put("changeByName", "HerokuConnect");
					fieldObj.put("changeDateTime", "2016-11-09T12:57:58.000Z");
					switch (fieldType) {
					case "date":
						fieldObj.put("fieldType", "DATE");
						break;
					case "timestamp":
						fieldObj.put("fieldType", "DATETIME");
						break;
					case "bool":
						fieldObj.put("fieldType", "BOOLEAN");
						break;
					default:
						fieldObj.put("fieldType", "STRING");
						break;
					}
					fieldsJSONArray.put(fieldObj);
				}
				recordJSON.put("fieldsChanged", fieldsJSONArray);
				dataArray.put(recordJSON);
			}
			layer7JSON.put("Data", dataArray);
			layer7JSON.put("DataSetName", "CRMRECORDS");
			layer7JSON.put("CorrelationId", "HC-" + System.currentTimeMillis());
			pushToHeroku(layer7JSON);
			genericDAO.insertRecord(new ArrayList<>(result.keySet()));
			System.err.println("Running........");
		}
	}

	private HttpEntity<String> createHttpRequestForReceiver(JSONObject jsonRequest) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.add("token", getIDPToken());
		HttpEntity<String> reqEntity = new HttpEntity<String>(jsonRequest.toString(), headers);
		return reqEntity;
	}

	private HttpEntity<String> createAuthenticateRequest() {
		JSONObject idpReq = new JSONObject();
		idpReq.put("userName", idpUserName);
		idpReq.put("password", idpPassword);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> req = new HttpEntity<String>(idpReq.toString(), headers);
		return req;
	}

	private String getIDPToken() {
		JSONObject ipdResponse = null;
		try {
			ipdResponse = RestClient.call(createAuthenticateRequest(), idpURL, HttpMethod.POST);
		} catch (Exception e) {
			System.err.println(e);
		}
		return ipdResponse.getString("token");
	}

	private void pushToHeroku(JSONObject jsonObject) {
		JSONObject result = RestClient.call(createHttpRequestForReceiver(jsonObject), herokuURL, HttpMethod.POST);
		System.err.println("Response from heroku is :" + result);
	}
}
