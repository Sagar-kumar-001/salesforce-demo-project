public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, Phone, Type FROM Account];
    }

    @AuraEnabled
    public static void deleteAccounts(List<Id> accountIds) {
        delete [SELECT Id FROM Account WHERE Id IN :accountIds];
    }

    @AuraEnabled
    public static void updateAccounts(List<Account> accounts) {
        Database.update(accounts,false);
    }

    @AuraEnabled
    public static void addAccount(String accountName, String website, String annualRevenue, String billingCity, String phone) {
        Account acc = new Account(
            Name = accountName,
            Website = website,
            AnnualRevenue = Decimal.valueOf(annualRevenue),
            BillingCity = billingCity,
            Phone = phone
        );
        insert acc;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accId){
        return [Select Id,Name,Email from Contact where AccountId=:accId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> get10Accounts() {
        return [SELECT Id, Name, Industry, Phone, Type FROM Account limit 10];
    }
}