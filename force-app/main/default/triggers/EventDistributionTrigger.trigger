trigger EventDistributionTrigger on Event_Distribution__c (before insert,after insert,after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        EventDistributionTriggerHandler.updatingCapacityOnCreatingOrUpdatingEventDistribution(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        EventDistributionTriggerHandler.updatingCapacityOnCreatingOrUpdatingEventDistribution(Trigger.new);
    }
}