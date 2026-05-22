public class Assignment_8_Apex {
	
    //1. Create an apex class with a function that show a message "Welcome to Salesforce "
    public static void showMessage(){
        System.debug('Welcome to Salesforce ');
    }
    
    
    //2. Print the fibonacci series. 1, 1, 2, 3, 5, 8, 13..
    public static void fibonacci(Integer n){
        Integer firstNum=0,secondNum=1;
        Integer sum=0;
        System.debug(firstNum);
        System.debug(secondNum);
        for(Integer i=1;i<n;i++){
            sum=firstNum+secondNum;
            System.debug(sum+',');
            firstNum=secondNum;
            secondNum=sum;
        }
    }
    
    
    //3. Print any Integer number in reverse order. Ex: 789234 => 432987
    public static void reverseNumber(Integer num){
        Integer reverseNum=0,lastDigit;
        while(num!=0){
            lastDigit=Math.mod(num,10);
            num/=10;
            reverseNum=reverseNum*10+lastDigit;
        }
        System.debug(reverseNum);
    }
    
    
    /*4. WAP to enter a startDate='06:07:55 2-jan-2016' & endDate='07:08:55 5-feb-2016' and
		display the difference between two dates in Years, months, days, hours,
		minutes,seconds." */
    public static Integer monthNum(String month){
        Integer numOfMonth;
        switch on month{
            when 'jan'{
                numOfMonth=1;
            }
            when 'feb'{
                numOfMonth=2;
            }
            when 'mar'{
                numOfMonth=3;
            }
            when 'apr'{
                numOfMonth=4;
            }
            when 'may'{
                numOfMonth=5;
            }
            when 'june'{
                numOfMonth=6;
            }
            when 'july'{
                numOfMonth=7;
            }
            when 'aug'{
                numOfMonth=8;
            }
            when 'sep'{
                numOfMonth=9;
            }
            when 'oct'{
                numOfMonth=10;
            }
            when 'nov'{
                numOfMonth=11;
            }
            when 'dec'{
                numOfMonth=12;
            }
            when else{
                numOfMonth=0;
            }
        }
        return numOfMonth;
    }
    
    public static void dateDifference(){
        Integer num=monthNum('jan');
        Integer num2=monthNum('feb');
        DateTime startDate=DateTime.newInstance(2016,num,2,6,7,55);
        DateTime endDate=DateTime.newInstance(2016,num2,5,7,8,55);
        
        Integer yearDifference=endDate.Year()-startDate.Year();
        Integer monthDiff=endDate.Month()-startDate.Month();
        Integer dayDiff=endDate.Day()-startDate.Day();
        Integer hourDiff=endDate.Hour()-startDate.Hour();
        Integer minDiff=endDate.Minute()-startDate.Minute();
        Integer secDiff=endDate.Second()-startDate.Second();
        System.debug('Differenc of year:'+yearDifference+' Month Difference:'+monthDiff+' Day Difference:'+dayDiff+
                     ' Hour difference:'+hourDiff+' Minutes Difference:'+minDiff+' Seconds Difference: '+secDiff);
    }
    //5. WAP to add two binary nos. '100101' & '0101101' which are in text format.
    
    public static void addBinary(String s1,String s2){
        Integer n1=Integer.valueOf(s1);
        Integer n2=Integer.valueOf(s2);
        Integer d1,d2,c=0;
        String sum='';
        while(n1!=0 || n2!=0){
            Integer add=0;
            d1=Math.mod(n1,10);
            d2=Math.mod(n2,10);
            if(d1==1 && d2==1 && c==0){
                add=0;
                c=1;
            }
            else if(d1==1 && d2==1 && c==1){
                add=1;
                c=1;
            }
            else if(d1==0 && d2==1 && c==1){
                add=0;
                c=1;
            }
            else if(d1==1 && d2==0 && c==1){
                add=0;
                c=1;
            }
            else if(d1==0 && d2==0 && c==1){
                add=1;
                c=0;
            }
            else if(d1==1 && d2==0 && c==0){
                add=1;
                c=0;
            }
            else if(d1==0 && d2==1 && c==0){
                add=1;
                c=0;
            }
            else{
                add=0;
                c=0;
            }
            
            sum=add+sum;
            n1/=10;
            n2/=10;
        }
        Integer s=n1+n2+c;
        if(s==1){
            sum=s+sum;
        }
        System.debug(sum);
    }
    
    
    /*6. Print all the Account Name in Account object in reverse order Ex: Name='LEARNOWX'
		=> 'XWONRAEL'.*/
    public static void printAccountName(){
        List<Account> acc=[Select Name from Account];
        for(Account a: acc){
            System.debug(a.Name.reverse());
        }
    }
        

	//7. Create 20 new Accounts Records in salesforce with at least 5 fields filled.
	public static void createAccounts(){
        List<Account> createAccount=new List<Account>();
        for(Integer i=1;i<=20;i++){
            Account newAccount=new Account();
            newAccount.AccountNumber='4788'+i;
            newAccount.Name='Account1'+i;
            newAccount.Branch__c='a08Qy00000FDVBqIAP';
            newAccount.Active__c='yes';
            newAccount.BillingCity='Noida';
            newAccount.BillingCountry='India';
            newAccount.Phone='987654321'+i;
            createAccount.add(newAccount);  
        }
        insert createAccount;
        
    }
    
    
	//8. Create 20 Opportunities with Closed Date, Stage and Opportunity Name.
    public static void createOpportunities(){
        Date d=Date.newInstance(2025,02,01);
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=1;i<=20;i++){
            Opportunity newOpp=new Opportunity();
            newOpp.CloseDate=d;
            newOpp.StageName='Closed Won';
            newOpp.Name='Test Opportunity'+i;
			
            oppList.add(newOpp);
			            
        }
        insert oppList;
        System.debug(oppList);
    }
    
    //9. Create 10 Products with different Product Names, Description & Family.
    public static void createProducts(){
        List<Product2> prodList=new List<Product2>();
        for(Integer i=1;i<=10;i++){
            Product2 p=new Product2();
            p.Name='product'+i;
            p.Description='product'+i+'is a very good product.';
            p.Family='Electronics';
            
            prodList.add(p);
        }
        insert prodList;
        System.debug(prodList);
    }
    
    
    //10. Display the current salesforce user details 'Name', 'Number' & 'EmailId'.
    public static void currentUserDetails(){
        
        System.debug(UserInfo.getName());
        System.debug(UserInfo.getUserEmail());
        User u=[Select Name,Email,Phone from User where id=:UserInfo.getUserId()];
		System.debug(u.Name);
        System.debug(u.Email);
        System.debug(u.Phone);
    }
    
    
    //11. Write a Script to get all the Contacts having same email as any Salesforce User.Email.
    public static void getContact(){
        Contact c=[Select Name from Contact where Email=:UserInfo.getUserEmail()];
        System.debug(c.Name);
    }
    
    
    //12. Create 10 Contacts with different Account(LookUp) values(Relationship with no same 2 accounts) in them.
    public static void createContact(){
        List<Contact> conList=new List<Contact>();
        List<Account> accList=[Select Id from Account limit 10];
        for(Integer i=0;i<10;i++){
            Contact cNew=new Contact();
            cNew.AccountId=accList[i].Id;
            cNew.LastName='Raj'+(i+1);
            
            conList.add(cNew);
        }
        
        insert conList;
        for(Contact c: conList){
            System.debug(c);
        }
       
    }
    
    //13. Print the Account Names in Alphabetical accending order.
    public static void getAccountNames(){
        List<Account> nameList=[Select Name from Account order by Name];
        for(Account a:nameList){
            System.debug(a);
        }
    }
    
    
    //14. Find all the Products having a Description field containing 'a' in it.
    public static void productDescription(){
        List<Product2> prodList=[Select Name from Product2 where Description like '%a%'];
        for(Product2 p: prodList){
            System.debug(p);
        }
    }
    
    
    //15. Delete all contacts belonging to Accounts Name FIELD having 'A' in them.
    public static void deleteContact(){
        List<Contact> contList=[Select Name from Contact where Account.Name like '%A%'];
        for(Contact c: contList){
            System.debug(c);
        }
        Delete contList;
    }
    
    
    //16. Update all Opportunity with future Closed Date by Opportunity Name=Opportunity Name + 'F'.
    public static void updateOpp(){
        List<Opportunity> oppList=[Select Name from Opportunity where CloseDate > :Date.TODAY()];
        for(Integer i=0;i<oppList.size();i++){
            oppList[i].Name+='F';
        }
        for(Opportunity op:oppList){
            System.debug(op);
        }
        update oppList;
        
    }
    
    //17. Create New Price book 'Algo Pricebook' and 10 Products with Prices in the Pricebook
    public static void newProductInAlgoPriceBook(){
        List<Product2> listProduct=new List<Product2>();
        for(Integer i=0;i<10;i++){
            Product2 p=new Product2();
            p.Name='Product'+(i+1);
            p.IsActive = true;
            listProduct.add(p);
        }
        insert listProduct;
        
        Pricebook2 pb=new Pricebook2();
        pb.Name='Algo Pricebook';
        pb.IsActive=true;
        
        insert pb;
        
        Pricebook2 pb2=[Select Id FROM Pricebook2 where IsStandard=true];
        List<PricebookEntry> listOfStandardPrice=new List<PricebookEntry>();
        List<PricebookEntry> listOfCustomPrice= new List<PricebookEntry>();
        
        for(Product2 p: listProduct){
            
            PricebookEntry standardPrice=new PricebookEntry();
            standardPrice.IsActive=true;
            standardPrice.Pricebook2Id=pb2.Id;
            standardPrice.Product2Id=p.Id;
            standardPrice.UnitPrice=100;
            
            listOfStandardPrice.add(standardPrice);
            
            
            PricebookEntry customPrice=new PricebookEntry();
            customPrice.Pricebook2Id=pb.Id;
            customPrice.Product2Id=p.Id;
            customPrice.IsActive=true;
            customPrice.UnitPrice=80;
            
            listOfCustomPrice.add(customPrice);
            
        }
        insert listOfStandardPrice;
        insert listOfCustomPrice;
    }    

    
    //18. Write a program in Salesforce to create another System admin user in your dev org with your email. 
    //Register the user manually.
    public static void createSystemAdminUser(){
        Profile p=[Select Id from Profile where Name='System Administrator'];
        String email=UserInfo.getUserEmail();
        User newUser=new User();
        newUser.LastName='Test System Admin';
        newUser.Alias='Abctest';
        newUser.ProfileId=p.Id;
        newUser.IsActive = true;
        newUser.Email=email;
        newUser.Username='atestUser123456789@gmail.com';
        newUser.TimeZoneSidKey='Asia/Kolkata';
        newUser.LocaleSidKey= 'en_IN';
        newUser.EmailEncodingKey='UTF-8';
        newUser.LanguageLocaleKey='en_US';
        insert newUser;
        System.debug(newUser);
    }



	//19. WAP to create 5 Case Records with all the values(Account, Contact, etc) filled in.
    public static void createCaseRecords(){
        List<Account> accList=[Select Id,Name from Account Limit 5];
        List<Contact> conList=[Select Id,Name from Contact Limit 5];
        List<Case> caseList=new List<Case>();
        for(Integer i=0;i<5;i++){
            Case newCase=new Case();
            newCase.AccountId=accList[i].Id;
            newCase.ContactId=conList[i].Id;
            newCase.Status='New';
            newCase.Origin='Phone';
            caseList.add(newCase);
        }
        insert caseList;
        System.debug(caseList);
    }


	//20. Manually add 2 (jpg and PDF) attachments under Accounts related list. WAP to copy the attachments to Contact 
      //  associated(parent child) with Account.
    public static void addAttachment(Id accId){
		List<ContentDocumentLink> accFiles=[Select ContentDocumentId from ContentDocumentLink where LinkedEntityId=:accId];
        List<Contact> contList=[Select Id from Contact where AccountId=:accId];
        
        List<ContentDocumentLink> conFileList=new List<ContentDocumentLink>();
        for(Contact c: contList){
            for(ContentDocumentLink cdk: accFiles){
                ContentDocumentLink conFile=new ContentDocumentLink();
                conFile.ContentDocumentId=cdk.ContentDocumentId;
                conFile.LinkedEntityId=c.Id;
                
                conFileList.add(conFile);
            }
        }
        insert conFileList;
    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
}