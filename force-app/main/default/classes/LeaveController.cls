public with sharing class LeaveController {
    @AuraEnabled(cacheable=true)
    public static List<Employees__c> getEmployees() {
        return [SELECT Id, Name FROM Employees__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Leave__c> getPendingLeaves() {
        return [
            SELECT Id, Name, Employees__r.Name, End_Date__c, Start_Date__c,
                   Leave_Type__c, Reason__c, Status__c
            FROM Leave__c
            WHERE Status__c = 'Pending'
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static void updateLeaveStatus(Id leaveId, String status) {
        update new Leave__c(
            Id = leaveId,
            Status__c = status
        );
    }

    @AuraEnabled(cacheable=true)
    public static List<Leave__c> getLeaveHistory(Id employeeId) {
        return [
            SELECT Id, End_Date__c, Leave_Type__c, 
                   Status__c, Days_Requested__c
            FROM Leave__c
            WHERE Employees__c = :employeeId
            ORDER BY End_Date__c DESC
        ];
    }
}