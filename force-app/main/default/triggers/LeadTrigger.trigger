trigger LeadTrigger on Lead (before insert,before update,after insert,after update,before delete,after delete,after undelete) {
	
    if(Trigger.isBefore && Trigger.isInsert){
         //LeadTriggerHandler.setLeadRating(Trigger.new);
        //LeadTriggerHandler.checkDuplicateLead(Trigger.new);
        //LeadTriggerHandler.emailToLeadEmailOnLeadCreation(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        //LeadTriggerHandler.checkDuplicateLead(Trigger.new);
    }
}