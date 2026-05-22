@isTest
public class AccountTriggerHandlerTest {
    //3.Whenever a new Account record is created then it needs to create an associated Contact record automatically.
    //@isTest
    /*static void createContactTest(){
        //Creating account
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
        Account acc=new Account();
        acc.Name='Test'+i;
        accList.add(acc);
    }
    
    //Refreshing Governor limits
    System.Test.startTest();
    Database.insert(accList,false);
    System.Test.stopTest();
    
    List<Contact> conList=[Select Id from Contact where AccountId =:accList[0].Id];
    System.assert(conList.size()>0);
    }*/
    
    //5.Write a trigger to create a related Contact of Account with the same phone as Account's phone if the custom checkbox field 
    //on Account is checked.
    /*@isTest
    static void AccountContactPhoneRelatedTest(){
    List<Account> accList=new List<Account>();
    for(Integer i=1;i<=5;i++){
    Account acc=new Account();
    acc.Name='Test';
    acc.Phone='12345';
    acc.Phone_Linked__c=true;
    accList.add(acc);
    }
    System.Test.startTest();
    Database.insert(accList,false);
    System.Test.stopTest();
    Set<Id> accId=new Set<Id>();
    for(Account acc:accList){
    accId.add(acc.Id);
    }
    List<Contact> conList=[Select Id,Phone,AccountId from Contact where AccountId IN:accId];
    System.assert(conList.size()>0);
    System.assertEquals('12345',conList[0].Phone);
    }*/
    
    //6.Whenever a user deletes an account send a confirmation email to the user
    /*@isTest
    static void confirmationEmailOnAccountDeletionTest() {
        // Create a test account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Delete the test account
        Database.DeleteResult res =  Database.delete(acc, false);
        Integer emailCount = Limits.getEmailInvocations(); // Capture email count

         // Verify that the deletion was successful
        System.Assert(res.isSuccess(),'The deletion should be successful.');

        // Verify that an email was sent
        System.assertEquals(1, emailCount, 'An email should be sent when an account is deleted.');
    }*/
    
    //7.Prevent a user from deleting an Active Account record.
    
    /*@isTest
	static void preventionOfActiveAccountDeletionTest() {
    // Step 1: Create and insert an Account with Active__c = 'Yes'
    	Account acc = new Account(Name = 'Test Account', Active__c = 'Yes');
    	insert acc;

    // Step 2: Attempt to delete the account
    	Database.DeleteResult res = Database.delete(acc, false);

    // Step 3: Assert that the deletion was prevented
    	System.assertEquals(false, res.isSuccess(), 'Account deletion should be prevented for active accounts');
	}*/
    
    
    /*9.Whenever Account's Phone field is updated then all related Contact's phone fields should also get updated with Parent Account's phone.
    @isTest
    static void updateContPhoneOnUpdatingAccPhoneTest(){
        Account acc=new Account();
        acc.Name='Test';
        insert acc;
        
        Contact c=new Contact();
        c.LastName='Kumar';
        c.AccountId=acc.Id;
        insert c;
        
        Account acc2=[Select Id,Phone from Account where Id=:acc.Id];
        acc2.Phone='12345';
        update acc2;
        Contact cUpdated=[Select Id,Phone from Contact where Id=:c.Id];
        System.assertEquals(acc2.Phone,cUpdated.Phone);
        
    }*/
    
    
    /*10"On Account creation if the industry is null then show an error message. If the industry is Media then populate rating as Hot otherwise 
     * populate rating as Cold.  
	While updating an account if you are updating the Phone field and does not put any value in the Phone field then show the error message. 
	Otherwise update the field and put the Description as Phone updated successfully. 
	Before deleting an Account check the Active status of the Account. If the Active status is Yes then show the error message. Otherwise delete 
	the Account.After creating an Account, create the related Opportunity if the Account Active status is not yes then show the error message."
	*/
    
    //11.Whenever the Account is created with Industry as Banking then create a contact for account, Contact Lastname as Account name and contact 
    //phone as account phone.
	/*@isTest
    static void createContIfIndustryIsBankingOnAccountTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test';
        acc.Industry='Banking';
        acc.Phone='12345';
        insert acc;
        
        //Fetching Related Contact
        Contact c=[Select Id,LastName,Phone from Contact where AccountId=:acc.Id];
        System.assertEquals(acc.Phone,c.Phone);
        System.assertEquals(acc.Name,c.LastName);
    }
    */
    
    //12.Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object.
    /*@isTest
    static void contactCreationCountEqualNoOfLocationTest(){
        Account acc=new Account();
        acc.Name='Test';
        acc.NumberofLocations__c=5;
        insert acc;
        
        List<Contact> conList=[Select Id from Contact where AccountId=:acc.Id];
        System.assertEquals(5,conList.size());
    }*/
    
    
    //17.Whenever a new Account is created with the same name then throw an error i.e. Prevent the users to create Duplicate Accounts.
    /*@isTest
    static void preventionOfDuplicateAccountCreationTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test';
        
        //Database insertion
        Database.SaveResult res=Database.insert(acc,false);
       	System.assert(res.isSuccess());
    }*/
    
    
    //18.Write a trigger in which if an account that has related contacts and the user tries to delete that account it throws you an error 
    //"Account cannot be deleted".
    @isTest
    static void accountDeletionPreventionIfContainsContactTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test';
        insert acc;
        
        //Contact Creation
        Contact c1=new Contact();
        c1.LastName='Test Contact 1';
        c1.AccountId=acc.Id;
        insert c1;
        
        Database.DeleteResult res=Database.delete(acc,false);
        System.assert(!res.isSuccess());
    }
    
    //68.Write a trigger that stops users from editing an Account record if it was updated in the past hour. If less than one hour has passed since the 
    //last update, show an error message and block the update.
    @isTest
    static void preventUserFromUpdatingAccountInAnHourTest(){
        //Account Creation
        Account acc=new Account(Name='Sagar');
        insert acc;
        
        //Update Account
      	acc.Phone='2345';
        update acc;
        
        //Fetching Account and updating it
        Account acc2=[Select Id,Name,Phone from Account where Id=:acc.Id];
        acc2.Phone='4332';
        Database.SaveResult res=Database.update(acc2,false);
        System.assert(!res.isSuccess());
    }
    
    //70.Write a trigger to prevent the deletion of related Contacts when their parent Account is deleted.
    @isTest
    static void preventDeletionOfContactOnRelatedAccountDeletionTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test';
        insert acc;
        
        //Related Contact creation
        Contact c=new Contact();
        c.LastName='Test contact';
        c.AccountId=acc.Id;
        insert c;
        
        //Deleting Account
        delete acc;
        List<Contact> cExistingList=[Select Id from Contact where Id=:c.Id];
        System.assert(cExistingList.size()>0);
    }
        
        
        
    //73."Create a field on Contact called ""Profile""(text 255)
    //When an Account is updated and the Website is filled in, update all the Profile field on all Contacts to:
    //Profile = Website + ‘/’ + First Letter of First Name + Last Name"
    @isTest
    static void updateProfileOnAllContactOnUpdatingAccWebsiteTest(){
        Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        List<Contact> conList=new List<Contact>();
        for(Integer i=1;i<=5;i++){
            Contact c=new Contact();
            c.LastName='test Contact '+i;
            c.AccountId=acc.Id;
            conList.add(c);
        }
        insert conList;
        
        Account acc2=[Select Id,Website from Account where Id=:acc.Id];
        acc2.Website='www.google.com';
        update acc2;
        
        List<Contact> conList2=[Select Id,Profile__c from Contact];
        for(Integer i=0;i<conList2.size();i++){
            System.assertEquals('www.google.com/test Contact '+(i+1),conList2[i].Profile__c);
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}