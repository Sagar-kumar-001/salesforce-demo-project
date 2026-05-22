@isTest
public class OpportunityTriggerHandlerTest {
    //13.Whenever Opportunity "Stage" is modified to "Closed Won" then set "Close Date" as "Today Date" and "Type" as 
    //"New Customer".
	@isTest
    static void oppStageModificationTest(){
        Opportunity opp=new Opportunity();
        opp.Name='Test Opp';
        opp.StageName='Prospecting';
        opp.CloseDate=Date.Today()+10;
        insert opp;
        
        Opportunity opp2=[Select Id,Name,StageName from Opportunity where Id=:opp.Id];
        opp2.StageName='Closed Won';
        update opp2;
        
        Opportunity oppUpdated=[Select Id,Name,StageName,CloseDate,Type from Opportunity where Id=:opp.Id];
        Date today=Date.Today();
        System.assertEquals(today,oppUpdated.CloseDate);
        System.assert(oppUpdated.Type=='New Customer');
    }
    
     //74."Create a field on Account called ""is_gold""(checkbox) default off,When an Opportunity is greater than $20k, mark is_gold to TRUE."

    @isTest
    static void checkAccIsGoldOrNotTestOnInsertion(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test Acc';
        insert acc;
        
        //Opportunity Creation
        Opportunity opp=new Opportunity();
        opp.Name='Test';
        opp.CloseDate=Date.Today();
        opp.StageName='Prospecting';
        opp.AccountId=acc.Id;
        opp.Amount=1234567;
        insert opp;
        
        //Fetching Account
        Account acc2=[Select Id,is_gold__c from Account where Id=:acc.Id];
        System.assert(acc2.is_gold__c);
        
    }
    
    @isTest
    static void checkAccIsGoldOrNotTestOnUpdate(){
        //Account Creation
        Account acc=new Account();
        acc.Name='Test Acc';
        insert acc;
        
        //Opportunity Creation
        Opportunity opp=new Opportunity();
        opp.Name='Test';
        opp.CloseDate=Date.Today();
        opp.StageName='Prospecting';
        opp.AccountId=acc.Id;
        opp.Amount=123;
        insert opp;
        
        //Fetching Opportunity
        Opportunity opp2=[Select Id,Amount from Opportunity where Id=:opp.Id];
        opp2.Amount=23456789;
        update opp2;
        
        //Fetching Account
        Account acc2=[Select Id,is_gold__c from Account where Id=:acc.Id];
        System.assert(acc2.is_gold__c); 
    }
    
    //69.Write a trigger to prevent multiple Opportunity creation for the same Account within a day or a single transaction.
    @isTest
    static void preventMultipleOppCreationInADayOrInASingleTransactionTest(){
        
    }
    
    
    
}