public with sharing class OpportunityContactService {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getContactPhones(Id oppId){
        List<String> phones=new List<String>();
        List<OpportunityContactRole> contacts=[Select Contact.Phone from OpportunityContactRole where OpportunityId=:oppId
        AND Role IN ('Business User','Decision Maker') AND Contact.Phone<>Null];
        for(OpportunityContactRole ocr:contacts){
            phones.add(ocr.Contact.Phone);
        }
        return phones;
    }
}