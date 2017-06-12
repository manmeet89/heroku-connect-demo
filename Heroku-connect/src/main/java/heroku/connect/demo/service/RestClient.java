/**
 *
 */
package heroku.connect.demo.service;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

/**
 * @author ManmeetFIL
 *
 */
public class RestClient {

	public static JSONObject call(HttpEntity<?> reqEntity, String url, HttpMethod method) {
		long startTime = System.currentTimeMillis();
		RestTemplate template = new RestTemplate();
		ResponseEntity<String> restResponse = null;
		JSONObject response = null;
		try {
			restResponse = template.exchange(url, method, reqEntity, String.class);
			response = new JSONObject(restResponse.getBody());
		} catch (Exception e) {
			System.err.println("*******************EXCEPTION*******************");
			throw e;
		} finally {
			System.err.println("Time Taken for REST call to URL - [" + url + "] is - " + (System.currentTimeMillis() - startTime) + "ms");
		}
		return response;
	}
}
