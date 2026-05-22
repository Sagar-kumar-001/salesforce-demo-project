trigger CourseTrigger on Course__c (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        CourseTriggerHandler.updatingEnrollmentStatusOfStudents(Trigger.new,Trigger.oldMap);
    }
}