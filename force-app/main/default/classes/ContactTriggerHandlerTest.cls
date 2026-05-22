@isTest
public class ContactTriggerHandlerTest {
    
    //8.While creating a contact, send the confirmation mail to the contact.
    /*@isTest
    static void contactCreationConfirmationMailTest(){
        Contact c=new Contact();
        c.LastName='test contact sagar ';
        c.Email='skforit360@gmail.com';
        insert c;
        Integer emailCount=Limits.getEmailInvocations();        
        
        System.assertEquals(1,emailCount);
    }
    
    
    //14.Create a custom field on Account object named Contact_Count__c. This field will contain the no of Contacts associated with the Account. 
    //Whenever a user creates, updates, deletes or undeletes any Contact record then Contact_Count__c field value should be updated accordingly.
	@isTest
    static void countContactTest(){
        Account acc=new Account();
        acc.Name='yujgfbdcsx';
        insert  acc;
        
        List<Contact> conList=new List<Contact>();
        for(Integer i=1;i<=5;i++){
            Contact c=new Contact();
            c.LastName='Test '+i;
            c.AccountId=acc.Id;
            conList.add(c);
        }
        insert conList;
        
        Account fetchedAcc=[Select Id,Contact_Count__c from Account where Id =:acc.Id];
        System.assertEquals(5,fetchedAcc.Contact_Count__c);
    }*/
    
    //15.Whenever a new contact is created for an existing account then set contact other phone as account phone.
    /*@isTest
    static void createContactForExistingAccountTest(){
        //Account creation
        Account acc=new Account();
        acc.Name='Cloud Analogy';
        acc.Phone='12345';
        insert acc;
        
        //Related contact creation
        contact cNew=new Contact();
        cNew.LastName='Saurav';
        cNew.AccountId=acc.Id;
        insert cNew;
        
        Contact updatedCon=[Select Id,OtherPhone from Contact where Id=:cNew.Id];
        System.assertEquals(acc.Phone,updatedCon.OtherPhone);
    }*/
    
    //16.Whenever a Contact's description is updated then its parent Account's description should also get updated by it.
    /*@isTest
    static void descriptionUpdationOfAccountOnUpdatingContactDescTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        //Related Contact creation
        Contact cNew=new Contact();
        cNew.LastName='Test';
        cNew.AccountId=acc.Id;
        insert cNew;
        
        Contact updateCon=[Select Id,Description from Contact where Id=:cNew.Id];
        updateCon.Description='Updated Desc';
        update updateCon;
        
        //Fetching Updated Account
        Account updatedAcc=[Select Id,Description from Account where Id=:acc.Id];
        System.assertEquals('Updated Desc',updatedAcc.Description);
    }*/
    
    //19.Whenever a contact record is inserted into the database, we need to check duplicate records using email,mobile and phone fields. 
    //If duplicate content is found, then throw error "Entered content is duplicate! kindly check and enter valid content".
    @isTest
    static void checkDuplicateContactTest(){
        //Contact Creation
        Contact c=new Contact();
        c.LastName='Test Contact';
        c.Email='sraj20211@gmail.com';
        c.MobilePhone='12345';
        c.Phone='09876';
        Database.insert(c,false);
        
        //New Contact creation to check for duplication
        Contact cNew=new Contact();
        cNew.LastName='Test 2';
        cNew.Email='sraj20211@gmail.com';
        Database.SaveResult res=Database.insert(cNew,false);
        System.assert(!res.isSuccess());
    }
    
    //20.Trigger to show an Error if there are already two Contacts present on an Account and the user tries to add one more Contact on it.
    @isTest
    static void errorIfAccountHasTwoOrMoreContactsTest(){
        //Account Creation
       	Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        //Contact Creation
        List<Contact> conList=new List<Contact>();
        for(Integer i=1;i<=2;i++){
            Contact c=new Contact();
            c.LastName='Test '+i;
            c.AccountId=acc.Id;
            conList.add(c);
        }
        
        //inserting this contact list into the testing framework
        Database.insert(conList,false);
       
        //Creating more than 2 contacts on a single account
        Contact cNew=new Contact();
        cNew.LastName='Test for Duplicate';
        Database.Saveresult res=Database.insert(cNew,false);
        
        //Checking for Error
        System.assert(!res.isSuccess());
    }
    
    
    //75."Create a field on Account called ""need_intel""(checkbox), default off
    //Create a field on Contact called ""Dead""(checkbox), default off
    //If 70% or more of the Contacts on an Account are Dead, mark the need_intel field to TRUE"
    @isTest
    static void markAccountAsNeedIntelTrueIf70PercentOrMoreContactsAreDeadTest(){
        Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        Contact c1=new Contact();
        c1.LastName='Test Contact 1';
        c1.AccountId=acc.Id;
        c1.Dead__c=true;
        insert c1;
        
        Contact c2=new Contact();
        c2.LastName='Test Contact 2';
        c2.AccountId=acc.Id;
        c2.Dead__c=false;
        insert c2;
        
        c2.Dead__c=true;
        update c2;
        Account acc2=[Select Id,need_intel__c from Account where Id=:acc.Id];
        System.assert(acc2.need_intel__c);
    }
    
    //72."On Account object we have a field named Type(picklist), add one more value Premium into this picklist field. When a new contact is 
    //added to an Account with the type field set to  Premium, a case should be automatically created. The case should:
	//1. Include the contact's name in the description field.
	//2. The case should be assigned to the Account owner."
	//Test Case 1
    @isTest
    static void createCaseOnContactCreationIfRelatedAccTypeIdPremiumPositiveTest(){
        //Account Creation with type as Premium
        Account acc=new Account();
        acc.Name='Test Account';
        acc.Type='Premium';
        insert acc;
        
        //Related Account Creation
        Contact c=new Contact();
        c.LastName='Test ';
        c.AccountId=acc.Id;
        insert c;
        
        //Asserting
        List<Case> caseList=[Select Id,Description,OwnerId from Case];
        System.assert(caseList.size()>0);
    }
    
    //Test Case 2
    @isTest
    static void createCaseOnContactCreationIfRelatedAccTypeIdNegativePositiveTest(){
        //Account Creation with type other than premium or null
        Account acc=new Account();
        acc.Name='Test Account';
        insert acc;
        
        //Related Account Creation
        Contact c=new Contact();
        c.LastName='Test ';
        c.AccountId=acc.Id;
        insert c;
        
        //Asserting
        List<Case> caseList=[Select Id,Description,OwnerId from Case];
        System.assert(caseList.size()==0);
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}