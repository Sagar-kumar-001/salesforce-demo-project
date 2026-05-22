public class EventDistributionTriggerHandler {
    public static void updatingCapacityOnCreatingOrUpdatingEventDistribution(List<Event_Distribution__c> eventDisList) {
        if (eventDisList.isEmpty()) {
            return; // Exit if no records
        }
        
        Set<Id> eventIdSet = new Set<Id>();

        // Collect related Event Ids
        for (Event_Distribution__c ed : eventDisList) {
            if (ed.Event__c != null && ed.Distribution__c != null) {
                eventIdSet.add(ed.Event__c);
            }
        }

        if (eventIdSet.isEmpty()) {
            return; // Exit if no valid Event Ids
        }

        // Fetch Events from Database
        Map<Id, Event__c> eventIdToEventMap = new Map<Id, Event__c>(
            [SELECT Id, Name, Event_Capacity__c FROM Event__c WHERE Id IN :eventIdSet]
        );

        if (eventIdToEventMap.isEmpty()) {
            return; // Exit if no matching events found
        }

        // Fetch Related Event Distribution Records from Database
        List<Event_Distribution__c> edList = [
            SELECT Id, Distribution__c, Status__c, Event__c 
            FROM Event_Distribution__c 
            WHERE Event__c IN :eventIdSet
        ];

        if (edList.isEmpty()) {
            return; // Exit if no event distributions found
        }

        // Map to track updated event capacities
        Map<Id, Decimal> eventMap = new Map<Id, Decimal>();

        // Process event distributions and update event capacity
        for (Event_Distribution__c ed : edList) {
            if (!eventIdToEventMap.containsKey(ed.Event__c)) {
                continue;
            }

            Decimal currentCapacity = eventIdToEventMap.get(ed.Event__c).Event_Capacity__c;
            Decimal updatedCapacity = (eventMap.containsKey(ed.Event__c))
                ? eventMap.get(ed.Event__c) - ed.Distribution__c
                : currentCapacity - ed.Distribution__c;

            // Update the eventMap with the new capacity
            eventMap.put(ed.Event__c, updatedCapacity);

            // Set the status based on available capacity
            if (updatedCapacity >= 0) {
                ed.Status__c = 'Confirmed';
            } else {
                ed.Status__c = 'Waiting';
            }
        }

        // Prepare Event records for update
        List<Event__c> updateEventList = new List<Event__c>();
        for (Id eventId : eventMap.keySet()) {
            Event__c e = eventIdToEventMap.get(eventId);
            e.Event_Capacity__c = eventMap.get(eventId);
            updateEventList.add(e);
        }

        // **Perform DML operations**
        try {
            if (!edList.isEmpty()) {
                update edList;  // Update Event Distribution first
            }
            if (!updateEventList.isEmpty()) {
                update updateEventList;  // Then update Event records
            }
        } catch (DmlException ex) {
            System.debug('DML Exception: ' + ex.getMessage());
        }
    }
}