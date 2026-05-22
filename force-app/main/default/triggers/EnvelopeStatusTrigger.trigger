/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 07-15-2025
 * @last modified by  : 
**/
trigger EnvelopeStatusTrigger on dfsle__EnvelopeStatus__c (after update) {
    Set<Id> oppIdsToUpdate = new Set<Id>();

    for (dfsle__EnvelopeStatus__c statusRecord : Trigger.new) {
        dfsle__EnvelopeStatus__c oldStatus = Trigger.oldMap.get(statusRecord.Id);

        if (
            statusRecord.dfsle__Status__c == 'Completed' &&
            oldStatus.dfsle__Status__c != 'Completed' &&
            statusRecord.dfsle__Opportunity__c != null
        ) {
            oppIdsToUpdate.add(statusRecord.dfsle__Opportunity__c);
        }
    }

    if (!oppIdsToUpdate.isEmpty()) {
        List<Opportunity> oppsToUpdate = [
            SELECT Id, Description
            FROM Opportunity
            WHERE Id IN :oppIdsToUpdate
        ];

        for (Opportunity opp : oppsToUpdate) {
            opp.Description = 'Agreement Signed';
        }

        update oppsToUpdate;
    }
}