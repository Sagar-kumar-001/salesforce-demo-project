public with sharing class getOppContactRoles {
    @AuraEnabled(cacheable=true)
    public static List<OpportunityContactRole> getContactRoles(Id oppId) {
        return [
            SELECT Id, Role, ContactId, OpportunityId
            FROM OpportunityContactRole 
            WHERE OpportunityId = :oppId
        ];
    }
}