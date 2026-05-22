public with sharing class WrapperClass {
    @AuraEnabled
    public static List<AccountWrapper> getAccounts(){
        try {
            List<Account> accList = [Select Id, Name, Phone from Account LIMIT 10];
            List<AccountWrapper> accWrapperList = new List<AccountWrapper>();
            for(Account acc: accList){
                AccountWrapper wrapper = new AccountWrapper();
                wrapper.id = acc.Id;
                wrapper.name = acc.Name;
                wrapper.phone = acc.Phone;
                accWrapperList.add(wrapper);
            }
            return accWrapperList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class AccountWrapper{
        @AuraEnabled public Id id;
        @AuraEnabled public String name;
        @AuraEnabled public String phone;
    }
}