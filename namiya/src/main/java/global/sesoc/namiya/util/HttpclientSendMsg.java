package global.sesoc.namiya.util;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class HttpclientSendMsg {

	private static final String USER_AGENT = "Mozila/5.0";
	public static String url = null;
	
	public static String sendPost(String accessToken) throws ClientProtocolException, IOException {
		
		//http client 생성
		CloseableHttpClient httpClient = HttpClients.createDefault(); 
		
		//get 메서드와 URL 설정
		HttpPost httpPost = new HttpPost(url);
		
		String token = "Bearer " + accessToken;
		
		//agent 정보 설정
		httpPost.addHeader("User-Agent", USER_AGENT);
		httpPost.setHeader("Access-Control-Allow-Origin", "*");
		httpPost.setHeader("Authorization", token);
		httpPost.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
		httpPost.setHeader("Access-Control-Max-Age", "3600");
		httpPost.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");
		
		//get 요청
		CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
		
//		System.out.println("GET Response Status");
//		System.out.println(httpResponse.getStatusLine().getStatusCode());
		
		// json 결과
		String json = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
//		System.out.println(json);
		httpClient.close();
		
		return json;
	}
}
