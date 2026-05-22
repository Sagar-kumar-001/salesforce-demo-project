trigger TaskTrigger on Task (before insert,after insert,before update,after update,after delete,before delete,after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            //TaskTriggerHandler.onlySystemAdminCanDeleteTask(Trigger.old);
        }
    }
}