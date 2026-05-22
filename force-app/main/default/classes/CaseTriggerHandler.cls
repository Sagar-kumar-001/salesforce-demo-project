/**
 * @description       : 
 * @author            : Sagar
 * @group             : 
 * @last modified on  : 05-22-2026
 * @last modified by  : 
**/
public with sharing class CaseTriggerHandler {

    public static void callExternalSystemOnCaseClosing(List<Case> caseList, Map<Id, Case> oldMap){
        if(caseList.size()>0){
            Set<Id> caseIdsToBeUpdated = new Set<Id>();
            for(Case c : caseList){
                if(c.Status=='Closed' && c.Status!=oldMap.get(c.Id).Status){
                    System.debug('Calling External System----');
                    caseIdsToBeUpdated.add(c.Id);
                    // System.debug('c.Description----'+c.Description);
                }
            }
            if(!caseIdsToBeUpdated.isEmpty()){
                callExternalSystem(caseIdsToBeUpdated);
            }
        }
    }

    @future(callout=true)
    public static void callExternalSystem(Set<Id> caseIdsToBeUpdated){
        List<Case> caseListToBeUpdated = [SELECT Id, Description, Test_Email__c FROM Case WHERE Id IN :caseIdsToBeUpdated];
        Boolean canUpdateEmail = Schema.sObjectType.Case.fields.Test_Email__c.isUpdateable();
        for(Case c : caseListToBeUpdated){
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.agify.io?name=sagar');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            System.debug('response---'+response);
            if(response.getStatusCode() == 200){
                System.debug('response-----'+response.getBody());
                c.Description = response.getBody();
                if(canUpdateEmail){
                    c.Test_Email__c = 'xyz@gmail.com';
                }
            }   
            if(response.getStatusCode() == 200){
                System.debug('Sucess---');
            } else if(response.getStatusCode() != 200){
                c.Description = response.getBody();
                if(canUpdateEmail){
                    c.Test_Email__c = 'xyz2@gmail.com';
                }
                System.debug('failed-----');
            }
        }  
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, caseListToBeUpdated);
        System.debug('decision-----'+decision);
        Database.update((List<Case>)decision.getRecords(), false);
        System.debug('decision.getRemovedFields()-------'+decision.getRemovedFields());
        // Database.update(caseListToBeUpdated,false);
    }


    //1.Whenever a case is created with origin as email then set status as new and Priority as Medium.
    public static void setStatusAsNewIfOriginIsEmailInCaseCreation(List<Case> caseList){
        for(Case c:caseList){
            if(c.Origin=='Email'){
                c.Status='New';
                c.Priority='Medium';
            }
        }
    }
    
    //4.When a Case is inserted on any Account, put the latest Case number on the Account in the custom field "Latest Case 
    //Inserted" field.
    public static void latestCaseInsert(List<Case> caseList){
        List<Account> accList=new List<Account>();
        for(Case newCase:caseList){
            if(newCase.AccountId!=Null){
                Account acc=new Account();
                acc.Id = newCase.AccountId;
                acc.Latest_Case_Inserted__c = newCase.CaseNumber;
                accList.add(acc);
            }
        }
        Database.Update(accList,false); 
    }
    
    //67.Automatically update Task status and Account description when Case status is modified. Populate latest Case Number and status in parent Account 
    //description. Update related Task status value same as Case status value.
    //
    public static void updateTaskStatusAndAccountDescOnCaseStatusUpdation(List<Case> newCaseList, Map<Id, Case> oldMap) {
        Set<Id> caseIdSet = new Set<Id>();
        Set<Id> accIdSet = new Set<Id>();
        System.debug('Checking for Git');
        for (Case c : newCaseList) {
            if (!oldMap.isEmpty() && c.Status != oldMap.get(c.Id).Status && c.AccountId != null) {
                caseIdSet.add(c.Id);
                accIdSet.add(c.AccountId);
            }
        }
        Map<Id, Case> caseIdToCaseMap = new Map<Id, Case>();
        Map<Id, String> caseIdToStatusMap = new Map<Id, String>();
        Map<Id, String> caseIdToNumberMap = new Map<Id, String>();
        Map<Id, Id> caseIdToAccountIdMap = new Map<Id, Id>();
        
        for (Case c : [SELECT Id, AccountId, Status, CaseNumber FROM Case WHERE Id IN :caseIdSet]) {
            caseIdToCaseMap.put(c.Id, c);
            caseIdToStatusMap.put(c.Id, c.Status);
            caseIdToNumberMap.put(c.Id, c.CaseNumber);
            caseIdToAccountIdMap.put(c.Id, c.AccountId);
        }

        List<Task> updatedTaskList = new List<Task>();
        for (Task t : [SELECT Id, WhatId FROM Task WHERE WhatId IN :caseIdSet]) {
            if (caseIdToStatusMap.containsKey(t.WhatId)) {
                t.Status = caseIdToStatusMap.get(t.WhatId);
                updatedTaskList.add(t);
            }
        }

        Map<Id, String> accIdToLatestCaseInfo = new Map<Id, String>();
        for (Id caseId : caseIdSet) {
            System.debug('Hello Hello');
            if (caseIdToAccountIdMap.containsKey(caseId)) {
                Id accId = caseIdToAccountIdMap.get(caseId);
                String caseInfo = 'Case Number: ' + caseIdToNumberMap.get(caseId) + ' --> Status: ' + caseIdToStatusMap.get(caseId);
                accIdToLatestCaseInfo.put(accId, caseInfo);
            }
        }
        
        List<Account> updatedAccList = new List<Account>();
        for (Account acc : [SELECT Id, Description FROM Account WHERE Id IN :accIdSet]) {
            if (accIdToLatestCaseInfo.containsKey(acc.Id)) {
                acc.Description = accIdToLatestCaseInfo.get(acc.Id);
                updatedAccList.add(acc);
            }
        }
        
        if (!updatedTaskList.isEmpty()) {
            update updatedTaskList;
        }
        if (!updatedAccList.isEmpty()) {
            update updatedAccList;
        }
    }
    
    //57.On Account object create three custom fields "Number of new cases", "Number of working cases" and "Number of Escalated cases". 
    //Write a trigger to update these three fields based on the status of related Cases. (We have a field named Status on Case object)
    public static void updateAccNumberOfCasesTypesOnCaseInsertionOrUpdation(List<Case> newCaseList){
        Set<Id> accId=new Set<Id>();
        for(Case c:newCaseList){
            if(c.AccountId!=Null){
                accId.add(c.AccountId);
            }
        }
        Map<Id,Decimal> accIdToNewCaseCountMap=new Map<Id,Decimal>();
        Map<Id,Decimal> accIdToWorkingCaseCountMap=new Map<Id,Decimal>();
        Map<Id,Decimal> accIdToEscalatedCaseCountMap=new Map<Id,Decimal>();
        
        List<AggregateResult> result1=[Select COUNT(Id) newCaseCount,AccountId accId from Case where AccountId IN:accId AND Status='New'
                                     group by AccountId];
        for(AggregateResult agr:result1){
            accIdToNewCaseCountMap.put((Id)agr.get('accId'),(Decimal)agr.get('newCaseCount'));
        }
        
        List<AggregateResult> result2=[Select COUNT(Id) workingCaseCount,AccountId accId from Case where AccountId IN:accId AND 
                                       Status='Working' group by AccountId];
        for(AggregateResult agr:result2){
            accIdToWorkingCaseCountMap.put((Id)agr.get('accId'),(Decimal)agr.get('workingCaseCount'));
        }
        
        List<AggregateResult> result3=[Select COUNT(Id) escalatedCaseCount,AccountId accId from Case where AccountId IN:accId AND 
                                       Status='Escalated' group by AccountId];
        for(AggregateResult agr:result3){
            accIdToEscalatedCaseCountMap.put((Id)agr.get('accId'),(Decimal)agr.get('escalatedCaseCount'));
        }
        
        List<Account> accList=[Select Id,Number_of_new_cases__c,Number_of_working_cases__c,Number_of_Escalated_cases__c from Account where Id
                              IN:accId];
        List<Account> updatedAccList=new List<Account>();
        for(Account acc:accList){
            Account a=new Account();
            a.Id=acc.Id;
            if(accIdToNewCaseCountMap.containsKey(acc.Id)){
                a.Number_of_new_cases__c=accIdToNewCaseCountMap.get(acc.Id);
            }
            if(accIdToWorkingCaseCountMap.containsKey(acc.Id)){
                a.Number_of_working_cases__c=accIdToWorkingCaseCountMap.get(acc.Id);
            }
            if(accIdToEscalatedCaseCountMap.containsKey(acc.Id)){
                a.Number_of_Escalated_cases__c=accIdToEscalatedCaseCountMap.get(acc.Id);
            }
            updatedAccList.add(a);
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }     
}