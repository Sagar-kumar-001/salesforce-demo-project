@isTest
public class CaseTriggerHandlerTest {
	//1.Whenever a case is created with origin as email then set status as new and Priority as Medium.
	//Test Case 1
    @isTest
	static void setStatusAsNewIfOriginIsEmailInCaseCreationTest1(){
        //Create 5 Cases
        List<Case> caseList=new List<Case>();
        for(Integer i=1;i<=5;i++){
            Case cNew=new Case();
            cNew.Origin='Email';
            caseList.add(cNew);
        }
        //Inserting this into testing environment
        System.Test.startTest();
        Database.insert(caseList,false);
        System.Test.stopTest();
        Case fetchedCase=[Select Id,Status,Priority from Case where Id=:caseList[0].Id];
        System.assertEquals('New',fetchedCase.Status);
        System.assertEquals('Medium',fetchedCase.Priority);
    }
    
    //Test Case 2
    @isTest
	static void setStatusAsNewIfOriginIsEmailInCaseCreationTest2(){
        //Create 5 Cases
        List<Case> caseList=new List<Case>();
        for(Integer i=1;i<=5;i++){
            Case cNew=new Case();
            cNew.Origin='Phone';
            cNew.Status='Working';
            cNew.Priority='High';
            caseList.add(cNew);
        }
        //Inserting this into testing environment
        System.Test.startTest();
        Database.insert(caseList,false);
        System.Test.stopTest();
        
        Case fetchedCase=[Select Id,Status,Priority from Case where Id=:caseList[0].Id];
        System.assertNotEquals('New',fetchedCase.Status);
        System.assertNotEquals('Medium',fetchedCase.Priority);
    }
    
    //4.When a Case is inserted on any Account, put the latest Case number on the Account in the custom field "Latest Case 
    //Inserted" field.
    @isTest
    static void latestCaseInsertTest(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test';
        insert acc;
        
        //Case creation related to account
        Case c=new Case();
        c.Status='New';
        c.Origin='Email';
        c.AccountId=acc.Id;
        insert c;
        
        //Fetching account and Case 
        Account acc2=[Select Id,Latest_Case_Inserted__c from Account where Id=:acc.Id];
        Case caseExisting=[Select Id,CaseNumber from Case where AccountId=:acc2.Id];
        System.assertEquals(acc2.Latest_Case_Inserted__c,caseExisting.CaseNumber);   
    }
    
    
    
    
    
    
    
    
    
    
}