public class CountContacts {

    @future
    public static void countContactsOfAccount(List<Id> accIdList){
        List<Account> accList=[Select Id,Name,Contact_Count__c,(Select Id from Contacts) from Account];
        for(Account acc:accList){
            acc.Contact_Count__c=acc.Contacts.size();
        }
        
        if(!accList.isEmpty()){
           update accList; 
        }
        for(Account acc:accList){
            System.debug(acc);
        }
        
    }
}