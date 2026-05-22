public class BatchApexDemo implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bx){
        System.debug('I am in start method');
        return Database.getQueryLocator([Select Id,Website from Account]);
    }
    public void execute(Database.BatchableContext bx,List<Account> accList){
        System.debug('I am in execute method and list size is:'+accList.size());
        List<Account> updatedAccList=new List<Account>();
        for(Account acc:accList){
            if(acc.website!=null){
                acc.website='www.salesforce.com';
                updatedAccList.add(acc);
            }
        }
        update updatedAccList;
    }
    public void finish(Database.BatchableContext bx){
        System.debug('I am in finish method');
    }
}