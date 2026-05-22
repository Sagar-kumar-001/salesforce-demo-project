/**
 * @description       : 
 * @author            : Sagar
 * @group             : 
 * @last modified on  : 05-22-2026
 * @last modified by  : 
**/
trigger ContactTrigger on Contact (before insert,after insert,before update,after update,after delete,before delete,after undelete) {
    if(Trigger.isBefore && Trigger.isInsert){
        //ContactTriggerHandler.contactCreationConfirmationMail(Trigger.new);
        //ContactTriggerHandler.createContactForExistingAccount(Trigger.new);
        //ContactTriggerHandler.checkDuplicateContact(Trigger.new);
        //ContactTriggerHandler.preventDuplicateContact(Trigger.new);
        
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        //ContactTriggerHandler.descriptionUpdationOfAccountOnUpdatingContactDesc(Trigger.new,Trigger.oldMap);
        //ContactTriggerHandler.countContact(Trigger.new);
        //ContactTriggerHandler.updateTotalOppAmtOfAccountAsTotalOfAllOppAmtOnUpdatingContact(Trigger.new,Trigger.old);
        //ContactTriggerHandler.markAccountAsNeedIntelTrueIf70PercentOrMoreContactsAreDead(Trigger.new,Trigger.oldMap);  
        // ContactTriggerHandler.updateLatestContactEmailOnAccount(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //ContactTriggerHandler.countContact(Trigger.new);
        //ContactTriggerHandler.errorIfAccountHasTwoOrMoreContacts(Trigger.new);
        //ContactTriggerHandler.creationOfContactRelationship(Trigger.new);
        //ContactTriggerHandler.createAccountOnContactCreation(Trigger.new);
        //ContactTriggerHandler.sendEmailToContactEmailOnItsCreation(Trigger.new);
        ContactTriggerHandler.createCaseOnContactCreationIfRelatedAccTypeIdPremium(Trigger.new);
        //ContactTriggerHandler.updateDefaultContactToFalseIfRelatedAccHasMoreThanOneContact(Trigger.new);
        //ContactTriggerHandler.populateContactCreatedFieldOnContactCreationOnRelatedAccount(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        //ContactTriggerHandler.countContact(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        //ContactTriggerHandler.countContact(Trigger.new);
    }
}