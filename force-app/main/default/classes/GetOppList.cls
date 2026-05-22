public with sharing class GetOppList {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpList() {
        return [Select Id,Name,AccountId,CloseDate,StageName,Amount,Account.Name from Opportunity];
    }
}