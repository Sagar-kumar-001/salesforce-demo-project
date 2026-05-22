/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : TestCalloutDogAPI
 * Author          : <YourName>
 * Created Date    : Feb 17, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Feb 17, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Feb 17, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public class TestCalloutDogAPI {

	@future(callout=true)
	public static void getData(){
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('callout:Dog_API_Test');
		request.setMethod('GET');
		HttpResponse response =  http.send(request);
		System.debug('response---'+response);
		if(response.getStatusCode() == 200){
			System.debug('response-----'+response.getBody());
		}
	}

}