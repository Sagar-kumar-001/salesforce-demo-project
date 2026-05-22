public class Assignment_9_Apex_Script_2 {
    
    /*1. Write a code to clone(copy ) 1 Opportunity with all Opportunity line items into a new Opportunity with 
     Closed Date = Old closed date + 30 days & Opportunity name = Opportunity Name+ 'Clone' 
	Code:*/
    public static void cloneOpportunity(Id oppId){
        Opportunity oldOpp=[Select Name,CloseDate from Opportunity where Id=:oppId];
        Opportunity newOpp=new Opportunity();
        newOpp.Name=oldOpp.Name+' Clone';
        newOpp.CloseDate=oldOpp.CloseDate+30;
        newOpp.StageName='Prospecting';
        
        insert newOpp;
        List<OpportunityLineItem> oppLineItemList=[Select Id,Name,Product2Id,UnitPrice,PricebookEntryId,Quantity,TotalPrice
                                                   from OpportunityLineItem where 
                                                   OpportunityId=:oppId];
               
        List<OpportunityLineItem> oppLItemList=new List<OpportunityLineItem>();
        
        for(OpportunityLineItem lineItem:oppLineItemList){
            OpportunityLineItem oppLNew=new OpportunityLineItem();
            oppLNew.OpportunityId=newOpp.Id;
            oppLNew.Quantity=lineItem.Quantity;
            oppLNew.PricebookEntryId=lineItem.PricebookEntryId;
            oppLNew.TotalPrice=lineItem.TotalPrice;
           	oppLItemList.add(oppLNew); 
            
        }
        
        insert oppLItemList;
    }
    
    //2. Write a Script to get all the Accounts having Opportunity Line Items Quantity > 100 under their Opportunities
    //(CLOSED WON only). 
	//Code:
    public static void getAccounts(){
        List<Opportunity> opp=[Select Id,AccountId from Opportunity where TotalOpportunityQuantity>100 AND 
                               StageName='Closed Won'];
        System.debug(opp);
    }

    
    //3. Create a new multi-picklist field In Lead Object "Records" [Buyer, Seller, Tenant , Landlord].
	//Code:
    public static void multiPickList(){
        
    }

    
    //4. Write a script to fetch all the Sellers and Tenants which are entered this year.
	//Code:
    public static void fetchSellerTenant(){
        Date startDate=Date.newInstance(System.today().year(),1,1);
        List<Lead> listSellerTenant=[Select Id,Name from Lead where Records__c includes('Seller','Tenant') AND 
                                 CreatedDate>=:startDate];
        System.debug(listSellerTenant);
    }

    /*5. Create a Custom Object Order_locoation.__c Create 3 fields in Order_locoation__c. 
		1. Total Distance(Integers) 
		2. Travel Location(A,B,C,D,E,F) single picklist. 
		3. Account Lookup. 
		5. Created a custom field in account Location single picklist type(A,B,C,D,E,F). 
		6. criteria Distance b/w location as follows: A to B- 10km B to C- 20km C to D- 38 km D to E- 83 km E to F- 73 km 
		Write a script to update the the total distance fields of Order_locoation__c with distance b/w travel Location and 
		account Location if and only if account having location A or F. 
		Code:   */
    public static void totalDistance(){
		Account acc=[Select Id,Name,Location__c from Account];
        Order_Lo__c ol=[Select Id,Name,Travel_Location__c,Total_Distance__c from Order_Lo__c where Account__c!=null];
        if(acc.Location__c=='A' && ol.Travel_Location__c=='A'){
            ol.Total_Distance__c=0;
        }
        else if(acc.Location__c=='A' && ol.Travel_Location__c=='B'){
            ol.Total_Distance__c=10;
        }
    }
    
    
    
    /*6. Create several Accounts and Opportunities and products.Write a Script to get all the Accounts having more than 2 
        Opportunities with Closed Won. 
		Code:*/
    public static void getAllAccounts(){
        
        List<AggregateResult> accOppList=[Select AccountId keyId,COUNT(Id) totalOpportunities from Opportunity 
                                      where StageName='Closed Won' group by AccountId
                                      Having count(Id)>2];
        System.debug(accOppList[0].get('totalOpportunities'));
        
        for (AggregateResult ar : accOppList) {
    		System.debug('Account ID: ' + ar.get('keyId') + ', Total Closed Won Opportunities: ' 
                         + ar.get('totalOpportunities'));
		}
    }


	//7. Create a look up[Lead] on product so that Products come over in related list of a Lead. Write script to create 3 
	//Leads and 5 Products with Lead lookup field. 
	//Code
    public static void createLeadAndProducts(){
        List<Product2> prodList=new List<Product2>();
        List<Lead> leadList=new List<Lead>();
        
        for(Integer i=0;i<3;i++){
            Lead newLead=new Lead();
            newLead.LastName='Demo Lead '+(i+1);
            newLead.Company='My Company '+(i+1);
            newLead.Status='Open Not Contacted';
            leadList.add(newLead);
        }
        
        insert leadList;
        
        for(Integer i=0;i<5;i++){
            Product2 newProd=new Product2();
            newProd.Name='Demo Product '+(i+1);
            newProd.Lead__c=leadList[0].Id;
            
            prodList.add(newProd);
        }
        
        insert prodList;
    }
	
    
    //8. "In Account Object create a picklist ""Working in (ASIA, EMA, NA, SA)"". Write a script to get the total 
    //""No of employees"" of all the Accounts working in ASIA and NA(North America)" 
    /*public static void EmployeesWorkingInAsiaAndNA(){
        List<Account> accList=[Select NumberOfEmployees from Account where Working_In__c='ASIA' OR Working_In__c='NA'];
        Integer sum=0;
		Map<Id,Integer> mp=new Map<Id,Integer>();
        for(Account acc:accList){
            mp.put(acc.Id,acc.NumberOfEmployees);
        }
        System.debug(mp);
        
    }*/
    
    
    //9. Write a Script to get all the Accounts having more than 2 Opportunity Line Items in their Opportunity.
    public static void getAllAccounts2(){
        List<OpportunityLineItem> opLnItemList=[Select OpportunityId,Id from OpportunityLineItem ];
    }
	/*
	 						Assignment-9
							Apex Script-2



 

10. In Account Object create a Multi picklist "Working in (ASIA, EMA, NA, SA)" Multipicklist. 

11. Write a script to get the total Quantity of Products sold in only Accounts working in ASIA. 


12. Create a Script to find out all the users in the systems who are having more than 20 Leads allocated[Owner] to them in 
month of Dec 2017 


13. Write a script to get all the Accounts having more than 10 opportunities whose status is closed won and the close date is 
between one month. 

14. Write a script to send Email to all users which are having more than 100 Account (Having phone number) and 30 contacts
(Having email address). 


15. Create an Object "Event" (Name Default field and "Event Date" Date time field). Another Junction Object "Event Participant" 
with 3 fields 1. lookup Contact 2. lookup Event 3. multipicklist ("Attendee Contact", "Presenter Contact","Organizer Contact") 
Write a script to create an Event with 10 "Event Participant" 4 with Attendee picklist, 4 with Presenter, 2 with organizer. 


16. Write a script to get all Accounts that are associated with opportunity and put the attachment from account to their 
opportunity. If the account does not have attachment, put opportunity close loss otherwise close won. 


17. "Create a new Product "Gandhiji Chasma". Add Price as 100$ in standard price book and any other price books as well. 
Create few opportunities with Opportunity line item "Gandhiji Chasma". Write a script to get the total Price of all the 
Opportunity sold having Product "Gandhiji Chasma"." 


18. Write a script to Send opportunity details to the Account's Contact's email address whose close date is 10 days later. 


19. Create a field Account 'Total Quantity ' .Write a script to find out those Account who have an odd number of Opportunity 
Line Items and put their Total Quantity in Account's field 'Total Quantity. Otherwise put 0 in 'Total Quantity field'. 


20. Write a Script to get all the Attachment And Contacts related to an Account. If there are more than one Attachments and 
one Contacts records related to account records then except one attachment and one Contact records all rest of the attachment 
and Contacts will be deleted. Also copy that single attachment under the single contact related to that account
 
	 */
    
    public static void method(){
        List<Opportunity> l=[Select Name,AccountId,StageName from Opportunity where StageName='Closed Won'];
        for(Opportunity op:l){
            System.debug('Name:'+op.AccountId+' Stage:'+op.StageName);
        }
    }
    
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
        for(Account acc:accList){
            System.debug(acc.Name);
        }
    }
    
    public static void test(){
        List<Account> accList=[Select Id,Name from Account where Name='Account11'];
        System.debug(accList);
        Database.delete(accList,false);
    }
    
    
}