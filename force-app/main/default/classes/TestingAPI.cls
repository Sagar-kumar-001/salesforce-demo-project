/**
* @File Name : TestingAPI.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 14, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 14, 2025 |   | Initial Version
**/

public class TestingAPI {
	public static void apiTesting(){
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndPoint('https://api.spoonacular.com/recipes/random?apiKey=fa5c20741443476fa54913def18c5c83');
		req.setMethod('GET');

		HttpResponse res = http.send(req);
		System.debug('---res---'+res);
		if(res.getStatusCode() == 200){
			System.debug('Response Body----'+res.getBody());
		}
	}
}