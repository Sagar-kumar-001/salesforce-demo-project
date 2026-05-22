public class SOQL_Questions {
	public static void allAccountsWithClosedWon(){
        List<Account> listAcc=[Select Id,Name from Account where Id IN (Select AccountId from Opportunity 
                                                                        where StageName='Closed Won')];
        for(Account acc:listAcc){
            System.debug('Name:'+acc.Name);
        }
    }
    
    
    public static void onlyClosedWonAccounts(){
        List<Account> accList=[Select Id,Name,(Select StageName from Opportunities) from Account where Id NOT IN(Select AccountId
                              from Opportunity where StageName!='Closed Won') AND Id IN(Select AccountId from Opportunity
                                                   where StageName='Closed Won')];
        for(Integer i=0;i<accList.size();i++){
            System.debug(accList[i].Name);
            for(Opportunity op:accList[i].Opportunities){
                System.debug(op.StageName);
            }
        }
    }
    
    
    //1.Write a SOQL query to get all opportunities related to a specific account, including their amount and stage.
    public static void getAllOpp(Id accId){
        List<Opportunity> oppList=[Select Id,Name,Amount,StageName from Opportunity where AccountId=:accId];
        for(Opportunity op: oppList){
            System.debug(op);
        }
    }
    
    
    //2.Write a SOQL query to find out the total number of accounts and the average annual revenue.
    public static void countAccount(){
        List<AggregateResult> accList=[Select COUNT(Id) totalAcc, AVG(AnnualRevenue) avgRevenue from Account];
		System.debug('Total Number of accounts:'+accList[0].get('totalAcc'));
        System.debug('Average Annual Revenue:'+accList[0].get('avgRevenue'));
    }
    
    //3.Write a SOQL query to find all contacts that were modified in the last 7 days.
    public static void allContacts(){
        Date d=Date.TODAY();
        List<Contact> contList=[Select LastName,LastModifiedDate	from Contact where LastModifiedDate>:d-7];
        for(Contact c: contList){
            System.debug(c);
        }
    }
    
    //4.Write a SOQL query to find all opportunities that are either in the "Prospecting" stage or have an amount greater than $500,000.
    public static void getOpp(){
        List<Opportunity> oppList=[Select Name From Opportunity where StageName='Prospecting' OR Amount>500000];
        for(Opportunity op: oppList){
            System.debug(op);
        } 
    }
    
    //5.Write a SOQL query  to retrieve the top 10 accounts by annual revenue.
    public static void top10Accounts(){
        List<Account> accList=[Select Name,AnnualRevenue from Account order by AnnualRevenue desc NULLS LAST];
        for(Account acc: accList){
            System.debug(acc);
        }
    }
	
    //6.Write a SOQL query to find all contacts who do not have an email address.
    public static void contactNotHavingEmail(){
        List<Contact> contList=[Select Name from Contact where Email=''];
        for(Contact c: contList){
            System.debug(c);
        }
    }
    
    //7.Write a SOQL query to get a list of contacts and their related account names, but only for contacts who have an email address.
    //8.Write a SOQL query to find all opportunities that were created in the current fiscal quarter.
    	
    //Select Name,CreatedDate from Opportunity where CreatedDate=THIS_FISCAL_QUARTER
    
    //9.Write a SOQL query to find all leads that are in either the "New" or "Working" status and were created in the last 90 days
    //Select Name,Status from Lead where CreatedDate=LAST_90_DAYS AND (Status='New' OR Status='Working - Contacted')
    
    //10.Write a SOQL query to find all the duplicate Contact records based on Email Id.
	public static void getDuplicateContact() {
    	List<AggregateResult> result = [SELECT Email, COUNT(Id) recordCount FROM Contact GROUP BY Email HAVING COUNT(Id) > 1];

        Set<String> duplicateEmails = new Set<String>();
        for (AggregateResult a : result) {
            duplicateEmails.add((String) a.get('Email'));
            System.debug('Duplicate Email: ' + a.get('Email') + ' --> Count: ' + a.get('recordCount'));
        }
    
        List<Contact> contList = new List<Contact>();
        if (!duplicateEmails.isEmpty()) {
            contList = [SELECT Id, Name, Email FROM Contact WHERE Email IN :duplicateEmails order by Email NULLS LAST];
        }
        for(Contact c:contList){
            System.debug(c);
    }
     	
    //11.Write a SOQL query to find all the Accounts which have more than 5 contacts.
   	//Select AccountId,count(Id) from Contact group by AccountId having count(Id)>5 

}
    //12.Write a SOQL query to retrieve the Account Name and Type for all Accounts owned by the current user.
    public static void accOwnedByCurrentUser(){
        List<Account> accList=[Select Name,Type from Account where OwnerId=:UserInfo.getUserId()];
        for(Account acc:accList){
            System.debug(acc);
        }
    }
	
    //13.Write a SOQL query to get all accounts and their total number of related opportunities.
    //Select Name,(Select Name from opportunities) from Account  
    public static void getAccAndRelatedOpp(){
        List<Account> accList=[Select Name,(Select Name from opportunities) from Account];
        for(Account acc:accList){
            System.debug(acc.Name+'--->'+acc.opportunities.size());
        }
    }
    
    //14.Write a SOQL query to find all contacts whose email addresses start with "support@company.com"
    //Select Name,Email from Contact where Email like 'support@company.com%'
   	
    //15.Write a SOQL query to find all opportunities that have a close date within the next 30 days.
    //Select Name from opportunity where CloseDate < NEXT_N_DAYS:30
    
    //16.Write a SOQL query to get the total number of leads and the maximum lead score (custom field)  from all leads.
    //Select count(Id),MAX(Lead_Score__c) from Lead 
    
    
    //17.Write a SOQL query to paginate through a list of accounts, retrieving 10 records at a time, starting from the 11th record.
    //Select Name from Account group by Name limit 10 offset 10
    
    //18.Write a SOQL query to fetch all Accounts of a specific record type.
    //
    public static void getAcc(){
        Map<id,RecordType> rt=new Map<id,RecordType> ([SELECT Id, Name FROM RecordType where Name='New Business']);
 
        List<Account> accList = [Select name From Account Where RecordTypeId IN :rt.keySet()];
        System.debug(accList);
    }
    
    //19.Write a SOQL query to retrieve all contacts and their related accounts, and for each account, get the related opportunities.
	//Select Name,(Select Name from Contacts where AccountId!=Null),(Select Name from Opportunities where AccountId!=Null) from 
	//Account where Id IN(Select AccountId from Contact)
    
    
    //20.Write a SOQL query to find all accounts owned by a specific user.
    //public static void accOwnedByCurrentUser(){
     //   List<Account> accList=[Select Name,Type from Account where OwnerId=:UserInfo.getUserId()];
      //  for(Account acc:accList){
       //     System.debug(acc);
     //   }
   // }
    
    
    //21.Write a SOQL query to find all contacts that were updated in the last month and have a specific email domain.
    //Select Name,LastModifiedDate from Contact where LastModifiedDate=LAST_MONTH AND Email like '%@gmail.com'
   
    
    //22.Write a SOQL query to get the total number of opportunities and their total value (sum of Amount) for each stage.
    //Select StageName,Count(Id),SUM(Amount) from opportunity group by StageName
    
    
    
    
}