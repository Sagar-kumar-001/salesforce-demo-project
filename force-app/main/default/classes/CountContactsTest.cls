@isTest
public class CountContactsTest {

    @isTest
    static void countContactsOfAccountTest(){
        List<Contact> conList=new List<Contact>();
        Account acc=new Account();
        acc.Name='Nescafe';
        insert acc;
        for(Integer i=0;i<10;i++){
            Contact c=new Contact();
            c.LastName='Raj';
            c.AccountId=acc.Id;
            conList.add(c);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        CountContacts.countContactsOfAccount(new List<Id>{acc.Id});
    }
}