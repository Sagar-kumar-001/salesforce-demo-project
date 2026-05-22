/**
 * @description       : 
 * @author            : Sagar
 * @group             : 
 * @last modified on  : 02-26-2026
 * @last modified by  : Sagar
**/
trigger CaseTrigger on Case (before insert,after insert,after update,before update,after delete,before delete,after undelete) {
    // /Business wants to turn trigger logic ON/OFF without deployment.
    test2__c settings = test2__c.getOrgDefaults();
    // test2__c settings = test2__c.getInstance('00eQy00000BbWlnIAF'); Profile based
    if(Trigger.isBefore && Trigger.isInsert){
        //CaseTriggerHandler.setStatusAsNewIfOriginIsEmailInCaseCreation(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert ){
        // CaseTriggerHandler.latestCaseInsert(Trigger.new);
        //CaseTriggerHandler.updateAccNumberOfCasesTypesOnCaseInsertionOrUpdation(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //CaseTriggerHandler.updateTaskStatusAndAccountDescOnCaseStatusUpdation(Trigger.new,Trigger.oldMap);
        //CaseTriggerHandler.updateAccNumberOfCasesTypesOnCaseInsertionOrUpdation(Trigger.new);
        
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        System.debug('settings.Trigger_Kill__c---'+settings.Trigger_Kill__c);
        if(settings != null && settings.Trigger_Kill__c == true){
            CaseTriggerHandler.callExternalSystemOnCaseClosing(Trigger.new,Trigger.oldMap);
        } else{
            System.debug('Trigger is disabled-------');
        }
    }
}