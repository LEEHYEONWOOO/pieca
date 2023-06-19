package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("news")
public class NewsController {
	
	@GetMapping("*")  // 설정되지 않은 모든 요청시 호출되는 메서드
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	// search.jsp 검색 클릭 -> ajax -> controller의 naversearch
		@RequestMapping("naversearch")
		@ResponseBody // RestController와 동일한 기능, 뷰없이 데이터를 클라이언트로 전송
		public JSONObject naversearch() throws ParseException {
			JSONObject jsonData=null;
			
			String clientId = "0aX5qsWcmly0lCZBWEqr";
			String clientSecret = "dj7NytCQSF";
			StringBuffer json = new StringBuffer();
			try {
				String text = URLEncoder.encode("전기차", "UTF-8");
				String apiURL = 
				"https://openapi.naver.com/v1/search/news.json?query=" + text+
				                                      "&display=100"; // json 결과
				URL url = new URL(apiURL);
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("X-Naver-Client-Id", clientId);
				con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
				int responseCode = con.getResponseCode();
				BufferedReader br;
				if (responseCode == 200) { // 정상 호출
					br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
				} else { // 에러 발생
					br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
				}
				String inputLine;
				while ((inputLine = br.readLine()) != null) {
					json.append(inputLine);
				}
				br.close();
			} catch (Exception e) {
				System.out.println(e);
			}
			//System.out.println(json);
			JSONParser jsonparser = new JSONParser();
			jsonData = (JSONObject)jsonparser.parse(json.toString());
			return jsonData;
		}
	
	
}
