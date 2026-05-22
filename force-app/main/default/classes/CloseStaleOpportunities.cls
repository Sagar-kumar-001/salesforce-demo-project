/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : CloseStaleOpportunities
 * Author          : Sagar
 * Created Date    : Mar 9, 2026
 * Last Modified By: Sagar
 * Last Modified On: Mar 9, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Mar 9, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

global class CloseStaleOpportunities implements Schedulable {
	public void execute(SchedulableContext sc) {
		Datetime staleTime = System.now().addDays(-90);
		List<Opportunity> oppList = [Select Id, StageName from Opportunity where lastModifiedDate < :staleTime AND IsClosed = false];
		for(Opportunity opp : oppList){
			opp.StageName = 'Closed Lost';
		}

		if(!oppList.isEmpty()){
			update oppList;
		}
	}
}