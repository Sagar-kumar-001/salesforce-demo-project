/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : OpportunityManager
 * Author          : Sagar
 * Created Date    : Jan 22, 2026
 * Last Modified By: Sagar
 * Last Modified On: Jan 22, 2026
 * Description     : This class implements for testing apex rest
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Jan 22, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

@RestResource(urlMapping='/firstWebResource/*')
global with sharing class OpportunityManager {

	@HttpGet
	global static Opportunity doGet() {
		RestRequest req = RestContext.request;
		System.debug('req---'+req);
		System.debug('req.requestURI---'+req.requestURI);
		RestResponse res = RestContext.response;
		System.debug('res---'+res);
		String oppId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		System.debug('oppId---'+oppId);
		Opportunity opp = [Select Name, StageName, Closedate from Opportunity where Id = :oppId];
		return opp; 
	}

	@HttpPost
	global static ID doPost(String name, String stage, String closedate, String source) {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		Opportunity newOpp = new Opportunity(
			name = name,
			stageName = stage,
			leadSource = source,
			closedate = Date.valueOf(closedate)
		);
		insert newOpp;
		return newOpp.Id;
	}

	@HttpPut
	global static Id upsertOpp(String name, String stage, String closedate, String source, String id){
		Opportunity thisOpportunity = new Opportunity(
			Id = id,
			name = name,
			stageName = stage,
			closedate = Date.valueOf(closedate),
			leadSource = source
		);
		upsert thisOpportunity;
		return thisOpportunity.Id;
	}

	@HttpPatch
	global static Id updateOppFields(){
		RestRequest req = RestContext.request;
		String oppId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Opportunity thisOpportunity = [Select Id from Opportunity where Id = :oppId];
		System.debug('req.requestBody---'+req.requestBody);
		System.debug('req.requestBody.toString()---'+req.requestBody.toString());
		Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
		System.debug('params---'+params);
		for(String fieldName : params.keySet()){
			thisOpportunity.put(fieldName, params.get(fieldName));
		}
		update thisOpportunity;
		return thisOpportunity.Id;
	}

	@HttpDelete
	global static void doDelete() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
	}

}