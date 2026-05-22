/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 07-14-2025
 * @last modified by  : 
**/
trigger DocuSignEnvelopeTrigger on dfsle__Envelope__c (after update) {
    // Set<Id> oppIdsToUpdate = new Set<Id>();

    // for (dfsle__Envelope__c env : Trigger.new) {
    //     dfsle__Envelope__c oldEnv = Trigger.oldMap.get(env.Id);

    //     // Check if it has been newly sent (you can use a different field if status becomes available)
    //     if (env.dfsle__Sent__c != null && oldEnv.dfsle__Sent__c == null && 
    //         env.dfsle__SourceId__c != null && 
    //         env.dfsle__SourceId__c.startsWith('006')) { // 006 = Opportunity prefix
    //         oppIdsToUpdate.add(env.dfsle__SourceId__c);
    //     }
    // }

    // if (!oppIdsToUpdate.isEmpty()) {
    //     List<Opportunity> oppsToUpdate = [
    //         SELECT Id, Description FROM Opportunity
    //         WHERE Id IN :oppIdsToUpdate
    //     ];

    //     for (Opportunity opp : oppsToUpdate) {
    //         opp.Description = 'Agreement Signed Successfully';
    //     }

    //     update oppsToUpdate;
    // }
}