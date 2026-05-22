public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accId){
        return [Select Id,Name,Phone,Email from Contact where AccountId=:accId];
    }

    @AuraEnabled(cacheable=true)
    public static boolean assignContactToClientContact(String accId,String contatcId){
        List<Account> accList=new List<account>();
        Account acc1=new Account();
        acc1.Id=accId;
        acc1.Client_Contact__c=contatcId;
        accList.add(acc1);
        if(!accList.isEmpty()){
            update accList;
            return true;
        }else{
            return false;
        }    
    }
        
}