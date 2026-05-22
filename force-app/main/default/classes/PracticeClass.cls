/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : PracticeClass
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

public with sharing class PracticeClass {

	@AuraEnabled(cacheable=true)
	public static List<Contact> getContactList() {
		// Your logic here
		return [Select Id,Name,AccountId,thebrokerup__Active__c from Contact];
	}

	@AuraEnabled(cacheable=true)
	public static List<Contact> findContact(String searchKey){
		return [Select Name,AccountId,thebrokerup__Active__c from Contact where Name LIKE : ('%'+searchKey+'%')];
	}

}