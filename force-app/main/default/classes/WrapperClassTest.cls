@isTest
public with sharing class WrapperClassTest {
    
    @isTest
    public static void getAccountsTest(){

        List<Account> accList = new List<Account>();
        for(Integer i=0;i<10;i++){
            Account acc = new Account();
            acc.Name = 'Test' +i;
            acc.Phone = '123456'+i;
            accList.add(acc);
        }

        insert accList;
        
        System.Test.startTest();
        List<WrapperClass.AccountWrapper> result = WrapperClass.getAccounts();
        System.Test.stopTest();
        System.assertEquals(10,result.size());
    }
}