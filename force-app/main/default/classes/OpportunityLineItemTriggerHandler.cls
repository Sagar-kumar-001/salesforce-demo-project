public class OpportunityLineItemTriggerHandler {
    //36.Create a custom field named "Number of Products"(number) on Account object. Write a trigger to count the number of 
    //OpportunityLineItems associated with an Opportunity and display the count on Account's custom field.
    public static void countOppLineItemOnAccount(List<OpportunityLineItem> oppLItemList){
        List<AggregateResult> agr=[Select Count(Id) countId,Opportunity.AccountId accId from OpportunityLineItem where Opportunity.AccountId!=Null
                                   group by Opportunity.AccountId];
        Map<Id,Integer> accIdToCountOpLI=new Map<Id,Integer>();
        for(AggregateResult result:agr){
            accIdToCountOpLI.put((Id)result.get('accId'),(Integer)result.get('countId'));
        }
        List<Account> accList=[Select Id,Name,Number_of_Products__c from Account where Id IN:accIdToCountOpLI.keySet()];
        for(Account acc:accList){
            acc.Number_of_Products__c=accIdToCountOpLI.get(acc.Id);
        }
        update accList;
    }
    
    //40.When an opportunity line item is created an email should go to Opportunity Account Client Contact — Client Contact would be a field
    //on Account lookup to contact.
    //Select Opportunity.Account.Client_Contact__r.Email,count(Id) from OpportunityLineItem group by Opportunity.Account.Client_Contact__r.Email
    
    
    //43.Write a trigger on the Opportunity line item when a line item deletes then delete the opportunity as well.
    public static void deleteOpportunityOnDeletionOfItsLineItem(List<OpportunityLineItem> oppLItemList){
        Set<Id> oppIdSet=new Set<Id>();
        for(OpportunityLineItem oppLItem: oppLItemList){
            oppIdSet.add(oppLItem.OpportunityId);
        }
        List<Opportunity> oppList=[Select Id from Opportunity where Id IN:oppIdSet];
        if(!oppList.isEmpty()){
            delete oppList;
        }
    }
    
    //44.Once an Opportunity line item is created, insert a quotation also.
    public static void insertQuatationOnCreatingOppLineItem(List<OpportunityLineItem> oppLItemList){
        Set<Id> oppIdSet=new Set<Id>();
        for(OpportunityLineItem oppLItem: oppLItemList){
            oppIdSet.add(oppLItem.OpportunityId);
        }
        List<Quotation__c> qList=new List<Quotation__c>();
        for(Id i:oppIdSet){
            Quotation__c qNew=new Quotation__c();
            qNew.Opportunity__c=i;
            qNew.Status__c='Draft';
            qList.add(qNew);
        }
        if(!qList.isEmpty()){
            insert qList;
        }
    }
    
    //53.Create an asset when creating an OpportunityLineItem with an associated Account.
    public static void creatingAssetOnCreatingOppLineItem(List<OpportunityLineItem> oppLItemList) {
        Set<Id> oppIdSet = new Set<Id>();
        for (OpportunityLineItem oppLItem : oppLItemList) {
            if (oppLItem.OpportunityId != null) {
                oppIdSet.add(oppLItem.OpportunityId);
            }
        }

        Map<Id, Id> oppIdToAccIdMap = new Map<Id, Id>();
        if (!oppIdSet.isEmpty()) {
            for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppIdSet]) {
                if (opp.AccountId != null) {  
                    oppIdToAccIdMap.put(opp.Id, opp.AccountId);
                }
            }
        }
        
        List<Asset> assetList = new List<Asset>();
        for (OpportunityLineItem oppLItem : oppLItemList) {
            Id accId = oppIdToAccIdMap.get(oppLItem.OpportunityId);
            if (accId != null && oppLItem.Product2Id != null) { // Ensure valid Account and Product
                Asset a = new Asset();
                a.Name='test';
                a.AccountId = accId;
                a.Product2Id = oppLItem.Product2Id;
                assetList.add(a);
            }
        }

        if (!assetList.isEmpty()) {
            insert assetList;
        }
    }
    
    
    
    
    
    
    
}