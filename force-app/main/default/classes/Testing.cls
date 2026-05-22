public class Testing {
    public static void test(){
        //Write an Apex script that queries all Account records with related Contact records, and groups the contacts by MailingState and calculates the average value of related
		//Opportunity records for each state.
		List<Account> accList=[Select Id,Name,(Select Id,Name,AccountId from Contacts where AccountId!=Null) from Account];
        for(Account acc:accList){
            System.debug(accList);
        }
        
    }
}