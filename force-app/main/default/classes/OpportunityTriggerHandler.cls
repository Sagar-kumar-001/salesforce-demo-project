/**
 * @description       : 
 * @author            : Sagar
 * @group             : 
 * @last modified on  : 02-25-2026
 * @last modified by  : Sagar
**/
public class OpportunityTriggerHandler {

    //Prevent users from changing Opportunity Amount after Stage = Closed Won.
    public static void preventAmountChangeAfterOppIsClosedWon(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        System.debug('oppList---->'+oppList);
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Closed Won' && oldMap.get(opp.Id).Amount != opp.Amount){
                opp.Amount.addError('Amount cannot be changed after Opportunity is Closed Won');
            }
        }
    }

    //When Opportunities are updated to Closed Won, update related Account Revenue field as the sum of all Closed Won Opportunities.
    public static void updateAccountRevenueOnClosedWonOpp(List<Id> oppIds){
        System.debug('oppIds---->'+oppIds);
        Set<Id> accIds1 = new Set<Id>();
        for(Opportunity opp : [SELECT Id,AccountId FROM Opportunity WHERE Id IN: oppIds]){
            accIds1.add(opp.AccountId);
        }
        AggregateResult[] agrList = [SELECT AccountId, SUM(Amount) totalAmount from Opportunity where AccountId IN: accIds1 GROUP BY AccountId];
        System.debug('agrList'+agrList);
        Set<Id> accIds = new Set<Id>();
        for(AggregateResult agr : agrList){
            accIds.add((Id) agr.get('AccountId'));
        }
        Map<Id,Decimal> accountIdToRevenueMap = new Map<Id, Decimal>();
        for(Account acc: [SELECT Id, AnnualRevenue FROM Account WHERE Id IN: accIds]){
            if(acc.AnnualRevenue == null){
                accountIdToRevenueMap.put(acc.Id,0);
            }
            else if(acc.AnnualRevenue != null){
                accountIdToRevenueMap.put(acc.Id,acc.AnnualRevenue);
            }
        }
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult agr : agrList){
            Account acc = new Account();
            acc.Id = (Id) agr.get('AccountId');
            acc.AnnualRevenue = (accountIdToRevenueMap.get((Id) agr.get('AccountId')) + (Double) agr.get('totalAmount'));
            accountListToUpdate.add(acc);
        }
        Database.update(accountListToUpdate,false);
    }

    //13.Whenever Opportunity "Stage" is modified to "Closed Won" then set "Close Date" as "Today Date" and "Type" as 
    //"New Customer".
    public static void oppStageModification(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        for(Opportunity opp:oppList){
            if(!oldMap.isEmpty() && opp.StageName!=oldMap.get(opp.Id).StageName){
                if(opp.StageName=='Closed Won'){
                    opp.CloseDate=Date.Today();
                    opp.Type='New Customer';
                }
            }
        }
    }
    
    /*23."A salesforce company named Cloud Pvt Ltd  plans to launch a product in different regions (ASIA, EMEA, NA, SA) across the globe.They 
	* also want to sell the products to their clients which are in ASIA,EMEA, NA and SA .
	From Admin point of view this particular scenario need to be logged into CRM for:	
	Create a Multi picklist name In Account Object ""Working in""
	Picklist Values:
	1. ASIA
	2. EMEA
	3. NA
	4. SA
	-Write a script to get the total Quantity of Products sold in only Accounts Working in = ASIA.
	-Write a Trigger to stop creating or updating Opportunities with Account having ""Working in = "ASIA" and Already 2 Closed Won Opportunity under same Account."
	*/
    public static void countOppQuantityOfAllAccountsWorkingInAisa(){
        Map<Id,Account> accIdToAccountMap=new Map<Id,Account>([Select Id,Name,Working_In__c from Account where 	Working_In__c Includes ('ASIA')]);
        List<AggregateResult> agr=[Select sum(TotalOpportunityQuantity) countOpp,AccountId accId from Opportunity where AccountId IN 
                                   :accIdToAccountMap.keySet() AND StageName='Closed Won' group by AccountId];
        for(AggregateResult result:agr){
            System.debug(result.get('countOpp'));
        }
    }
    
    public static void preventCreationAndUpdationOfOppInAccWorkingInAsiaAndHave2OrMore(List<Opportunity> oppList){
        List<AggregateResult> agr=[Select count(Id) countId,AccountId accId from Opportunity where StageName = 'Closed Won' group by AccountId Having count(Id)>=2];
        Map<Id,Integer> accIdToCountOppMap=new Map<Id,Integer>();
        for(AggregateResult result:agr){
            accIdToCountOppMap.put((Id)result.get('accId'),(Integer)result.get('countId'));
        }
        for(Opportunity opp:oppList){
            if(accIdToCountOppMap.containsKey(opp.AccountId)){
                opp.addError('Already 2 or more opportunity so cannot create or update another one');
            }
        }
    }
    
    
    //51.Add a field Multi-select Picklist on Account and Opportunity as well and add values A,B,C,D,F. Now if we update an Opportunity
    // with this multi-select value Account should also update with the same picklist values.    
    public static void updateAccountPicklistValueSameAsOppPicklistValue(List<Opportunity> newOppList, Map<Id,Opportunity> oldMap){
        Map<Id,Opportunity> accIdToOppMap=new Map<Id,Opportunity>();
        for(Opportunity opp:newOppList){
            if(!oldMap.isEmpty() && opp.Select_ABCDEF__c!=oldMap.get(opp.Id).Select_ABCDEF__c){
                accIdToOppMap.put(opp.AccountId,opp);
            }
        }
        List<Account> accList=[Select Id,Name,Select_ABCDE__c from Account where Id IN:accIdToOppMap.keySet()];
        List<Account> updatedAccList=new List<Account>();
        for(Opportunity opp:newOppList){
            if(accIdToOppMap.containsKey(opp.AccountId)){
                Account acc=new Account();
                acc.Id=opp.AccountId;
                acc.Select_ABCDE__c=opp.Select_ABCDEF__c;
                updatedAccList.add(acc);
            }
        }
        update updatedAccList;
    }
    
    
    //74."Create a field on Account called ""is_gold""(checkbox) default off,When an Opportunity is greater than $20k, mark is_gold to TRUE."
    public static void checkAccIsGoldOrNot(List<Opportunity> oppList){
        Map<Id,Opportunity> accIdToOppMap=new Map<Id,Opportunity>();
        for(Opportunity opp:oppList){
            if(opp.AccountId!=Null && opp.Amount>20000){
                accIdToOppMap.put(opp.AccountId,opp);
            }
        }
        List<Account> accList=new List<Account>();
        for(Opportunity opp:oppList){
            if(accIdToOppMap.containsKey(opp.AccountId)){
                Account acc=new Account();
                acc.Id=opp.AccountId;
                acc.is_gold__c=true;
                accList.add(acc);
            }
        }
        update accList;
    }
    
    //45.Update the Account name with the Opportunity name that has the highest amount.
    public static void updateAccountNameWithOppNameHavingHighestAmount(List<Opportunity> oppList){
        Set<Id> accIdSet=new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.AccountId!=Null){
                accIdSet.add(opp.AccountId);
            }
        }
        List<Opportunity> oppList2=[Select Id,Name,Amount from Opportunity where AccountId IN:accIdSet];
        List<AggregateResult> result=[Select MAX(Amount) maxAmount,AccountId accId from Opportunity where AccountId IN:accIdSet group by AccountID];
        
        List<Account> accList=[Select Id,Name from Account where Id IN:accIdSet];
        Map<Id,Decimal> accIdToMaxOppAmountMap=new Map<Id,Decimal>();
        for(AggregateResult agr:result){
            accIdToMaxOppAmountMap.put((Id)agr.get('accId'),(Decimal)agr.get('maxAmount'));
        }
        List<Account> updatedAccList=new List<Account>();
        for(Opportunity opp:oppList){
            if(accIdToMaxOppAmountMap.containsKey(opp.AccountId) && opp.Amount==accIdToMaxOppAmountMap.get(opp.AccountId)){
                Account acc=new Account();
                acc.Id=opp.AccountId;
                acc.Name=opp.Name;
                updatedAccList.add(acc);
            }
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }
    
    
    //47.Create a custom field on Account named "Close All Opportunities"(checkbox). Automatically close Opportunities with probability 
    //greater than 70% when checkbox is checked on Account.
    public static void closeAllOppInAnAccountHavingProbabilityMoreThan70(List<Opportunity> oppList) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null && opp.Probability > 70 && opp.StageName != 'Closed Won') {
                accountIds.add(opp.AccountId);
            }
        }
        if (accountIds.isEmpty()) {
            return; 
        }
        Map<Id, Boolean> accountCheckboxMap = new Map<Id, Boolean>();
        for (Account acc : [SELECT Id, Close_All_Opportunities__c FROM Account WHERE Id IN :accountIds AND Close_All_Opportunities__c = true]){
            accountCheckboxMap.put(acc.Id, acc.Close_All_Opportunities__c);
        }
        if (accountCheckboxMap.isEmpty()) {
            return;
        }
        List<Opportunity> updatedOppList = new List<Opportunity>();
        for (Opportunity opp : oppList) {
            if (accountCheckboxMap.containsKey(opp.AccountId)) {
                Opportunity updatedOpp = new Opportunity(Id = opp.Id, StageName = 'Closed Won');
                updatedOppList.add(updatedOpp);
            }
        }
        if (!updatedOppList.isEmpty()) {
            update updatedOppList;
        }
    }
    
    //52.Create a field on Opportunity as Client Contact, Once an Opportunity Client Contact updates then update Account Client Contact with 
    //the same on Opportunity Client Contact.
    public static void updateClientContactOfAccountOnUpdatingClientContactOfOpp(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        Set<Id> accIdSet=new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.AccountId!=Null && opp.Client_Contact__c!=oldMap.get(opp.Id).Client_Contact__c){
                accIdSet.add(opp.AccountId);
            }
        }
        List<Account> accList=new List<Account>();
        for(Opportunity opp:oppList){
            if(accIdSet.contains(opp.AccountId)){
                Account acc=new Account();
                acc.Id=opp.AccountId;
                acc.Client_Contact__c=opp.Client_Contact__c;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    //56."Update Account rating based on Total amount of related Opportunities. 
	//-> If total amount of related opportunities is less than or equal to 50k the update Account rating to ""Cold""
	//-> If total amount of related opportunities is less than or equal to 1L the update Account rating to ""Warm""
	//-> If total amount of related opportunities is more than 1L the update Account rating to ""Hot"""
    public static void updateRatingOnAccountBasedOnOppAmount(List<Opportunity> oppList){
        Set<Id> accId=new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.AccountId!=Null){
                accId.add(opp.AccountId);
            }
        }
        List<AggregateResult> result=[Select SUM(Amount) totalOppAmount,AccountId accId from Opportunity where AccountId IN:accId group by AccountId];
        Map<Id,Decimal> accIdToTotalOppAmountMap=new Map<Id,Decimal>();
        for(AggregateResult agr:result){
            accIdToTotalOppAmountMap.put((Id)agr.get('accId'),(Decimal)agr.get('totalOppAmount'));
        }
        List<Account> updatedAccList=new List<Account>();
        List<Account> accList=[Select Id,Rating from Account where Id IN:accId];
        for(Account acc:accList){
            Account a=new Account();
            if(accIdToTotalOppAmountMap.get(acc.Id)> 100000){
                a.Id=acc.Id;
                a.Rating='Hot';
                updatedAccList.add(a);
            }
            else if(accIdToTotalOppAmountMap.get(acc.Id)>50000){
                a.Id=acc.Id;
                a.Rating='Warm';
                updatedAccList.add(a);
            }
            else{
                a.Id=acc.Id;
                a.Rating='Cold';
                updatedAccList.add(a);
            }
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }
    
    
    
    //63.Whenever Opportunity stage is updated and Opportunity does not have any related Task, then create a new task. If the Opportunity has 
    //a related task then update the Opportunity stage in the description field of the related Task.
    public static void insertTaskOrUpdateItsDescriptionOnUpdatingOpportunityStage(List<Opportunity> newOppList, Map<Id, Opportunity> oldMap) {
        Set<Id> oppIdSet = new Set<Id>();
        for (Opportunity opp : newOppList) {
            if (oldMap.containsKey(opp.Id) && opp.StageName != oldMap.get(opp.Id).StageName) {
                oppIdSet.add(opp.Id);
            }
        }
		//Fetch existing tasks related to these Opportunities
        List<Task> taskList = [SELECT Id, Description, WhatId FROM Task WHERE WhatId IN :oppIdSet];
        
        Set<Id> taskOppIdSet = new Set<Id>(); // Store Opportunity IDs that have Tasks
        for (Task t : taskList) {
            taskOppIdSet.add(t.WhatId);
        }
        
		//Find Opportunities that do NOT have related Tasks
        List<Opportunity> oppList = new List<Opportunity>();
        if (!taskOppIdSet.isEmpty()) {
            oppList = [SELECT Id FROM Opportunity WHERE Id NOT IN :taskOppIdSet AND Id IN :oppIdSet];
        } else {
            oppList = [SELECT Id FROM Opportunity WHERE Id IN :oppIdSet];
        }
        
        List<Task> taskInsertList = new List<Task>();
        List<Task> taskUpdateList = new List<Task>();
        
        for (Opportunity opp : oppList) {
            Task t = new Task();
            t.WhatId = opp.Id;
            t.Status = 'Not Started';
            t.Subject = 'Call';
            t.Priority = 'Normal';
            taskInsertList.add(t);
        }
        
		//Update existing Tasks if Opportunity has a Task
        for (Task t : taskList) {
            if (oldMap.containsKey(t.WhatId)) {
                Task tNew = new Task();
                tNew.Id = t.Id;
                tNew.Description = oldMap.get(t.WhatId).StageName;
                taskUpdateList.add(tNew);
            }
        }
        
        if (!taskInsertList.isEmpty()) {
            insert taskInsertList;
        }
        if (!taskUpdateList.isEmpty()) {
            update taskUpdateList;
        }
    }
    
    //69.Write a trigger to prevent multiple Opportunity creation for the same Account within a day or a single transaction.
    public static void preventMultipleOppCreationInADayOrInASingleTransaction(List<Opportunity> oppList) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : oppList) {
            if(opp.AccountId!=Null){
                accountIds.add(opp.AccountId);
            }
        }
        
        Map<Id,Date> accountToLastOppDate = new Map<Id,Date>();
        for(Opportunity opp : [SELECT Id, AccountId, CreatedDate FROM Opportunity WHERE AccountId IN :accountIds AND CreatedDate = TODAY]) {
            accountToLastOppDate.put(opp.AccountId, opp.CreatedDate.date());
        }
        
        for(Opportunity opp : oppList) {
            if (oppList.size() > 1) {
                opp.addError('Cannot create more than one Opportunity in a single transaction.');
            }
            if (accountToLastOppDate.containsKey(opp.AccountId)) {
                opp.addError('An Opportunity has already been created for this Account today.');
            }
        }
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}