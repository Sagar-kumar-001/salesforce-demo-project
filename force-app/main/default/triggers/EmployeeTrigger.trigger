trigger EmployeeTrigger on Employee__c (before insert,after insert,before delete,after delete,before update,after update,after undelete) {
    if(Trigger.isAfter && Trigger.isInsert){
        //EmployeeTriggerHandler.updateMaxMinSalaryFieldOnCompany(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //EmployeeTriggerHandler.updateMaxMinSalaryFieldOnCompany(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        //EmployeeTriggerHandler.activeEmployeeCantBeDeleted(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        //EmployeeTriggerHandler.deletedEmployeeCountUpdationOnAccount(Trigger.old);
        //EmployeeTriggerHandler.updateMaxMinSalaryFieldOnCompany(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
        //EmployeeTriggerHandler.undeleteEmpRecordAndUpdateCountOfDeletedEmployeeOnAccount(Trigger.new);
    }
}