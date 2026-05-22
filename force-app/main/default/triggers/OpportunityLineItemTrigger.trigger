trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert,after insert,after update,before update,after delete,before delete,after undelete) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //OpportunityLineItemTriggerHandler.countOppLineItemOnAccount(Trigger.new);                                                             
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //OpportunityLineItemTriggerHandler.countOppLineItemOnAccount(Trigger.new);
        //OpportunityLineItemTriggerHandler.insertQuatationOnCreatingOppLineItem(Trigger.new);
        //OpportunityLineItemTriggerHandler.creatingAssetOnCreatingOppLineItem(Trigger.new); 
    }
    if(Trigger.isAfter && Trigger.isDelete){
        //OpportunityLineItemTriggerHandler.countOppLineItemOnAccount(Trigger.old); 
        //OpportunityLineItemTriggerHandler.deleteOpportunityOnDeletionOfItsLineItem(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        //OpportunityLineItemTriggerHandler.countOppLineItemOnAccount(Trigger.new); 
    }
    
    
}