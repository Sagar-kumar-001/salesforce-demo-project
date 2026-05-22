public with sharing class AccountData {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, Phone, Type FROM Account];
    }

    @AuraEnabled
    public static void deleteAccounts(List<Id> accountIds) {
        Database.delete( [SELECT Id FROM Account WHERE Id IN :accountIds],false);
    } 

    @AuraEnabled
    public static void updateAccounts(List<Account> accounts) {
        update accounts;
    }
    
    @AuraEnabled
    public static void addAccount(String accountName,String phone,String website, String annualRevenue, String billingCity){
        Account acc=new Account();
        acc.Name=accountName;
        acc.Phone=phone;
        acc.BillingCity=billingCity;
        acc.Website=website;
        acc.AnnualRevenue=Decimal.valueOf(annualRevenue);
        insert acc;
    }
}