/**
 * @description       : 
 * @author            : Sagar
 * @group             : 
 * @last modified on  : 02-25-2026
 * @last modified by  : Sagar
**/
public class ContactTriggerHandler {

    public static void updateLatestContactEmailOnAccount(List<Contact> newList, Map<Id, Contact> oldMap){
        System.debug('newList===='+newList);
        if(newList.size()>0){
            List<Account> accList = new List<Account>();
            for(Contact c: newList){
                if(c.AccountId!= null && c.Email!=oldMap.get(c.Id).Email){
                    Account acc = new Account();
                    acc.Id = c.AccountId;
                    acc.Latest_Contact_Email__c = c.Email;
                    accList.add(acc);
                }
            }
            Database.update(accList, false);
        }
    }
    
    //8.While creating a contact, send the confirmation mail to the contact.
    public static void contactCreationConfirmationMail(List<Contact> conList){
        List<Messaging.singleEmailMessage> msgList=new List<Messaging.singleEmailMessage>();
        Messaging.singleEmailMessage msg=new Messaging.singleEmailMessage();
        List<String> emailList=new List<String>();
        for(Contact c:conList){
            emailList.add(c.Email);
        }
        
        msg.setToAddresses(emailList);
        msg.setSubject('Contact creation');
        msg.setPlainTextBody('Contact created successfully!');
        msgList.add(msg);
        Messaging.sendEmail(msgList);
    }
    
    
    //14.Create a custom field on Account object named Contact_Count__c. This field will contain the no of Contacts associated with the Account. 
    //Whenever a user creates, updates, deletes or undeletes any Contact record then Contact_Count__c field value should be updated accordingly.
    public static void countContact(List<Contact> conList) {
        Set<Id> accIds = new Set<Id>();
        for (Contact con : conList) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        if (accIds.isEmpty()) {
            return;
        }
        List<AggregateResult> aContact = [SELECT COUNT(Id) cnt, AccountId FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId];
        
        Map<Id, Integer> accCount = new Map<Id, Integer>();
        for (AggregateResult ar : aContact) {
            accCount.put((Id) ar.get('AccountId'), (Integer) ar.get('cnt'));
        }
        List<Account> accToUpdate = [SELECT Id, Contact_Count__c FROM Account WHERE Id IN :accCount.keySet()];
        for (Account acc : accToUpdate) {
            acc.Contact_Count__c = accCount.get(acc.Id);
        }
        if (!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
    
    
    
    //15.Whenever a new contact is created for an existing account then set contact other phone as account phone.
    public static void createContactForExistingAccount(List<Contact> conList){
        Set<Id> accId=new Set<Id>();
        for(Contact cNew:conList){
            accId.add(cNew.AccountId);
        }
        Map<Id,String> idToPhoneMap=new Map<Id,String>();
        List<Account> accList=[Select Id,Name,Phone from Account where Id IN:accId];
        for(Account acc:accList){
            idToPhoneMap.put(acc.Id,acc.Phone);
        }
        
        for(Contact c:conList){
            if(c.AccountId!=Null){
                c.OtherPhone=idToPhoneMap.get(c.AccountId);
            }
        }
    }
    
    
    //16.Whenever a Contact's description is updated then its parent Account's description should also get updated by it.
    public static void descriptionUpdationOfAccountOnUpdatingContactDesc(List<Contact> newConList, Map<Id,Contact> oldMap){
        Map<Id,String> IdToDescriptionMap=new Map<Id,String>();
        for(Contact cNew:newConList){
            if(!oldMap.isEmpty() && cNew.Description!=oldMap.get(cNew.Id).Description){
                IdToDescriptionMap.put(cNew.AccountId,cNew.Description);
            }
        }
        List<Account> accList=[Select Id,Name from Account where Id IN :IdToDescriptionMap.keySet()];
        for(Account acc:accList){
            acc.Description=IdToDescriptionMap.get(acc.Id);
        }
        update accList;
    }
    
    
    //19.Whenever a contact record is inserted into the database, we need to check duplicate records using email,mobile and phone fields. 
    //If duplicate content is found, then throw error "Entered content is duplicate! kindly check and enter valid content".
    public static void checkDuplicateContact(List<contact> conList){
        List<Contact> existingContLIst=[Select Id,Name,Email,Phone,MobilePhone from Contact];
        Map<Id,String> conIdToEmailMap=new Map<Id,String>();
        Map<Id,String> contIdToPhoneMap=new Map<Id,String>();
        Map<Id,String> contIdToMobileMap=new Map<Id,String>();
        for(Contact c:existingContLIst){
            conIdToEmailMap.put(c.Id,c.Email);
            contIdToPhoneMap.put(c.Id,c.Phone);
            contIdToMobileMap.put(c.Id,c.MobilePhone);
        }
        for(Contact c:conList){
            if(c.Email==conIdToEmailMap.get(c.Id) || c.Phone==contIdToPhoneMap.get(c.Id) || c.MobilePhone==contIdToMobileMap.get(c.Id)){
                c.addError('Entered content is duplicate! kindly check and enter valid content');
            }
        }
    }
    
    
    //20.Trigger to show an Error if there are already two Contacts present on an Account and the user tries to add one more Contact on it.
    public static void errorIfAccountHasTwoOrMoreContacts(List<Contact> conList){
        Set<Id> accId=new Set<Id>();
        for(Contact c:conList){
            accId.add(c.AccountId);
        }
        Map<Id,Integer> accIdToCountOfContactMap=new Map<Id,Integer>();
        List<AggregateResult> result=[Select count(Id) countId,AccountId accId from Contact where AccountId IN:accId group by AccountId];
        for(AggregateResult ar:result){
            accIdToCountOfContactMap.put((Id)ar.get('accId'),(Integer)ar.get('countId'));
        }
        for(Contact c:conList){
            if(accIdToCountOfContactMap.containsKey(c.AccountId) && accIdToCountOfContactMap.get(c.AccountId)>=2){
                c.addError('Already have 2 or more accounts');
            }
        }
    }
    
    /*25.Create the field called "Contact Relationship" checkbox on the Contact Object and create the related object called "Contact Relationship"
which is a related list to the Contacts(Look Up Relationship). When we create contact by checking the Contact Relationship checkbox, then 
Contact Relationship will be created automatically for that contact.*/
    public static void creationOfContactRelationship(List<Contact> conList){
        List<Contact_Relationship__c> crList=new List<Contact_Relationship__c>();
        for(Contact con:conList){
            if(con.Contact_Relationship__c==true){
                Contact_Relationship__c cr=new Contact_Relationship__c();
                cr.Name='CR-1 '+con.Name;
                cr.Contact__c=con.Id;
                crList.add(cr);
            }
        }
        insert crList;
    }
    
    //35.Write a trigger on contact to prevent duplicate records based on Contact Email & Contact Phone.
    public static void preventDuplicateContact(List<Contact> conList){
        Map<Id,Contact> conIdToContactMap=new Map<Id,Contact>([Select Id,Name,Email,Phone from Contact]);
        List<String> email=new List<String>();
        List<String> phone=new List<String>();
        for(Id i:conIdToContactMap.keySet()){
            email.add(conIdToContactMap.get(i).Email);
            phone.add(conIdToContactMap.get(i).Phone);
        }
        for(Contact c:conList){
            if(c.Email!=null){
                if(email.contains(c.Email)){
                    c.addError('Duplicate Contact cannot be created');
                }
            }else if(c.Phone!=null){
                if(Phone.contains(c.Phone)){
                    c.addError('Duplicate Contact cannot be created');
                }
            }
        }
    }
    
    //38.Create Account record whenever new contact is created without an account.
    public static void createAccountOnContactCreation(List<Contact> conList){
        List<Account> accList=new List<Account>();
        for(Contact c:conList){
            Account acc=new Account();
            acc.Name=c.LastName;
            accList.add(acc);
        }
        insert accList;
    }
    
    
    //39.Write a trigger on Contact, when contact is inserted an email should be sent to the contact email id with a specified template. 
    //So first you need to create a text template.
    public static void sendEmailToContactEmailOnItsCreation(List<Contact> conList){
        //setTemplateId(templateId)
        List<Messaging.SingleEmailMessage> msgList=new List<Messaging.SingleEmailMessage>();
        Id tempId=[Select Id from EmailTemplate where Name='Contact Trigger Test'].Id;
        for(Contact c:conList){
            Messaging.SingleEmailMessage msg=new Messaging.SingleEmailMessage();
            msg.setTemplateId(tempId);
            msg.setToAddresses(new List<String>{c.Email});
            msg.setTargetObjectId(c.Id);
            msgList.add(msg);
        }
        Messaging.sendEmail(msgList);
    }
    
    //54.When Contact update collects all opportunity Amount And Update this amount on Account Level Field (Total Opportunity Amount).
    public static void updateTotalOppAmtOfAccountAsTotalOfAllOppAmtOnUpdatingContact(List<Contact> newConList,List<Contact> oldConList){
        Set<Id> accId=new Set<Id>();
        for(Contact c:newConList){
            if(c.AccountId!=Null){
                accId.add(c.AccountId);
            }
        }
        List<AggregateResult> result=[Select SUM(Amount) totalOppAmt ,AccountId accId from Opportunity where AccountId IN:accId group by AccountId];
        Map<Id,Decimal> accIdToTotalOppAmtMap=new Map<Id,Decimal>();
        List<Account> updatedAccList=new List<Account>();
        for(AggregateResult agr:result){
            Account acc=new Account();
            acc.Id=(Id)agr.get('accId');
            acc.Total_Opportunity_Amount__c=(Decimal)agr.get('totalOppAmt');
            updatedAccList.add(acc);
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }
    
    //72."On Account object we have a field named Type(picklist), add one more value Premium into this picklist field. When a new contact 
    //is added to an Account with the type field set to Premium, a case should be automatically created. The case should:
    //1. Include the contact's name in the description field.
    //2. The case should be assigned to the Account owner."
    public static void createCaseOnContactCreationIfRelatedAccTypeIdPremium(List<Contact> conList){
        Set<Id> conIdSet=new Set<Id>();
        //Storing All Contact Ids in which AccountId is not null
        for(Contact c:conList){
            if(c.AccountId!=Null){
                conIdSet.add(c.Id);
            }
        }
        
        //Fetching All Contacts records which is associated with any account and it's Account Type is Premium.
        Map<Id,Contact> conIdToConMap=new Map<Id,Contact>([Select Id,Name,AccountId,Account.OwnerId from Contact where Id IN:conIdSet AND
                                                           Account.Type='Premium']);
        List<Case> caseList=new List<Case>();
        
        //Iterating through the fetched contacts and creating the case
        for(Id i:conIdToConMap.keySet()){
            Case c=new Case();
            c.Status='New';
            c.Origin='Phone';
            c.Description=conIdToConMap.get(i).Name;
            c.ContactId=i;
            c.AccountId=conIdToConMap.get(i).AccountId;
            c.OwnerId=conIdToConMap.get(i).Account.OwnerId;
            caseList.add(c);
        }
        
        //Bulk DML Operation.
        if(!caseList.isEmpty()){
            insert caseList;
        }
    }
    
    //75."Create a field on Account called ""need_intel""(checkbox), default off
    //Create a field on Contact called ""Dead""(checkbox), default off
    //If 70% or more of the Contacts on an Account are Dead, mark the need_intel field to TRUE"
    public static void markAccountAsNeedIntelTrueIf70PercentOrMoreContactsAreDead(List<Contact> newConList, Map<Id, Contact> oldMap) {
        Set<Id> accIdSet = new Set<Id>();
        
        //Collect Account IDs where Dead__c field changed
        for (Contact c : newConList) {
            if (c.AccountId != null && (!oldMap.containsKey(c.Id) || c.Dead__c != oldMap.get(c.Id).Dead__c)) {
                accIdSet.add(c.AccountId);
            }
        }
        
        //Query Accounts and related Contacts
        Map<Id,Integer> accToTotalContacts = new Map<Id,Integer>();
        Map<Id,Integer> accToDeadContacts = new Map<Id,Integer>();
        
        for (Account acc : [SELECT Id, need_intel__c, (SELECT Id, Dead__c FROM Contacts) FROM Account WHERE Id IN :accIdSet]) {
            Integer totalContacts = 0;
            Integer deadContacts = 0;
            for (Contact c : acc.Contacts) {
                totalContacts++;
                if (c.Dead__c == true) {
                    deadContacts++;
                }
            }
            
            accToTotalContacts.put(acc.Id, totalContacts);
            accToDeadContacts.put(acc.Id, deadContacts);
        }
        
        //Update Accounts if 70% or more Contacts are Dead
        List<Account> updatedAccounts = new List<Account>();
        
        for (Id accId : accIdSet) {
            Integer totalContacts = accToTotalContacts.get(accId);
            Integer deadContacts = accToDeadContacts.get(accId);
            
            if (totalContacts > 0 && (deadContacts * 100 / totalContacts) >= 70) {
                updatedAccounts.add(new Account(Id = accId, need_intel__c = true));
            }
            else{
                updatedAccounts.add(new Account(Id = accId, need_intel__c = false));
            }
        }
        
        if (!updatedAccounts.isEmpty()) {
            update updatedAccounts;
        }
    }
    
    //64."Create a field on Account called ""Only_Default_Contact""(checkbox), default off,When a new Account is created, create a new Contact 
    //that has the following data points
	//First Name = ""Info""
	//Last Name = ""Default""
	//Email = ""info@websitedomain.tld""
	//Only_Default_Contact = TRUE
	//When the Account has more than 1 Contact, update Only_Default_Contact to FALSE."
    public static void updateDefaultContactToFalseIfRelatedAccHasMoreThanOneContact(List<Contact> conList){
        Set<Id> accId=new Set<Id>();
        Set<Id> conId=new Set<Id>();
        for(Contact c:conList){
            if(c.AccountId!=Null){
                accId.add(c.AccountId);
                conId.add(c.Id);
            }
        }
        List<Account> accList=[Select Id,Only_Default_Contact__c,(Select Id from Contacts) from Account where Id IN:accId];
        Map<Id,Integer> accIdToContactCountMap=new Map<Id,Integer>();
        
        for(Account acc:accList){
            accIdToContactCountMap.put(acc.Id,acc.Contacts.size());
        }
        List<Contact> conList2=[Select Id,Name,AccountId from Contact where Id IN:conId];
        List<Account> updatedAccList=new List<Account>();
        for(Contact c:conList2){
            if(accIdToContactCountMap.get(c.AccountId)>1){
                Account acc=new Account();
                acc.Id=c.AccountId;
                acc.Only_Default_Contact__c=false;
                updatedAccList.add(acc);
            }
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }
    
    //65."Create a field on Account called  ""Contact_Created__c ""(checkbox), default off.Create an apex trigger on the contact object and 
    //every time a new contact will be created and an account will be selected in the creation of that contact object then on that account 
    //object a checkbox filed ( Contact_Created__c ) will be checked true, which represent that this account has a contact."
    public static void populateContactCreatedFieldOnContactCreationOnRelatedAccount(List<Contact> conList){
        Set<Id> accId=new Set<Id>();
        for(Contact c:conList){
            if(c.AccountId!=Null){
                accId.add(c.AccountId);
            }
        }
        List<Account> accList=[Select Id,Name,Contact_Created_c__c from Account where Id IN:accId];
        List<Account> updatedAccList=new List<Account>();
        for(Account acc:accList){
            Account a=new Account();
            a.Id=acc.Id;
            a.Contact_Created_c__c=true;
            updatedAccList.add(a);
        }
        if(!updatedAccList.isEmpty()){
            update updatedAccList;
        }
    }
    
    
    
    
    
}