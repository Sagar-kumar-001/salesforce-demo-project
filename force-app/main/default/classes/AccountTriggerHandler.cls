public class AccountTriggerHandler {
    
    //Trigger Framework test
    public void OnBeforeInsert(List<Account> newAccountList){
        //AccountActions.updateAccount(newAccountList);
    }
    public static void createRating(List<Account> accList){
        for(Account a:accList){
            if(a.Industry=='Media'){
                a.Rating='Hot';
            }
        }
    }
    
    
    
    //3.Whenever a new Account record is created then it needs to create an associated Contact record automatically.
    public static void createContact(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        for(Account acc: accList){
            Contact con=new Contact();
            con.LastName=acc.Name+' Contact';
            con.AccountId=acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    
    
    //5.Write a trigger to create a related Contact of Account with the same phone as Account's phone if the custom checkbox field 
    //on Account is checked.
    public static void AccountContactPhoneRelated(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        for(Account acc: accList){
            if(acc.Phone_Linked__c==true){
                Contact cNew=new Contact();
                cNew.LastName=acc.Name+' New Contact';
                cNew.AccountId=acc.Id;
                cNew.Phone=acc.Phone;
                conList.add(cNew);
            }
            
        }
        
        if(!conList.isEmpty()){
            Database.insert(conList,false);
        }
    }
    
    
    //6.Whenever a user deletes an account send a confirmation email to the user.
    public static void confirmationEmailOnAccountDeletion(List<Account> accList){
        List<Messaging.singleEmailMessage> msgList=new List<Messaging.singleEmailMessage>();
        
        Messaging.singleEmailMessage msg=new Messaging.singleEmailMessage();
        String email=UserInfo.getUserEmail();
        msg.setToAddresses(new List<String>{email});
        msg.setSubject('Account Deletion Confirmation');
        msg.setPlainTextBody('This Account is deleted successfully!');
        msgList.add(msg);
        
        Messaging.sendEmail(msgList);
    }
    
    
    //7.Prevent a user from deleting an Active Account record.
    public static void preventionOfActiveAccountDeletion(List<Account> accList){
        for(Account acc:accList){
            if(acc.Active__c=='Yes'){
                acc.addError('Cannot delete an account');
            }
        }
    }
    
    
    //9.Whenever Account's Phone field is updated then all related Contact's phone fields should also get updated with Parent 
    //Account's phone.
    public static void updateContPhoneOnUpdatingAccPhone(List<Account> newAccList,Map<Id,Account> oldMap){
        Map<Id,String> idAccountMap=new Map<Id,String>();
        for(Account acc:newAccList){
            if(!oldMap.isEmpty() && acc.phone!=oldMap.get(acc.Id).phone){
                idAccountMap.put(acc.Id,acc.Phone);
            }
        }
        
        List<Contact> conList=[Select Id,Name,Phone,AccountId from Contact where AccountId IN :idAccountMap.keySet()];
        
        for(Contact c:conList){
            c.Phone = idAccountMap.get(c.AccountId);
        }  
        update conList;
    }
    
    /*10"On Account creation if the industry is null then show an error message. If the industry is Media then populate rating 
    * as Hot otherwise populate rating as Cold.
    * 
    * While updating an account if you are updating the Phone field and does not put any value in the Phone field then show 
    * the error message. Otherwise update the field and put the Description as Phone updated successfully.
    *  
    * Before deleting an Account check the Active status of the Account. If the Active status is Yes then show the error 
    * message. Otherwise delete the Account.
    * 
    * After creating an Account, create the related Opportunity if the Account Active status is not yes then show the error 
    * message."
    */
    public static void errorOnAccountCreation(List<Account> accList){
        for(Account acc:accList){
            if(acc.Industry== Null){
                acc.addError('Industry is null');
            }
            else if(acc.Industry=='Media'){
                acc.Rating='Hot';
            }
            else{
                acc.Rating='Cold';
            }
        }
    }        
    
    public static void updatingPhoneOnAccount(List<Account> newAccList,Map<Id,Account> oldMap){
        Map<Id,String> idToAcc=new Map<Id,String>();
        
        for(Account acc:newAccList){
            if(!oldMap.isEmpty() && acc.phone!=oldMap.get(acc.Id).phone){
                if(acc.phone==Null){
                    acc.addError('Phone number should not be null');
                }
                else{
                    acc.Description='Phone updated successfully';
                }
            }
        }
    }    
    
    /*public static void preventionOfActiveAccountDeletion(List<Account> accList){for(Account acc:accList){
if(acc.Active__c=='Yes'){
acc.addError('Cannot delete an account');
}
}
} */    
    
    public static void createRelatedOppOnAccount(List<Account> accList){
        List<Opportunity> oppList=new List<Opportunity>();
        for(Account acc:accList){
            Opportunity oppNew=new Opportunity();
            oppNew.StageName='Prospecting';
            oppNew.Name='Trigger Opp';
            oppNew.CloseDate=Date.today();
            oppNew.AccountId=acc.Id;
            if(acc.Active__c=='Yes'){
                oppList.add(oppNew);
            }
            else{
                acc.addError('Cannot create opportunity if account is inactive');
            }
        }
        insert oppList;
    }
    
    
    //11.Whenever the Account is created with Industry as Banking then create a contact for account, Contact Lastname as Account name and contact 
    //phone as account phone.
    public static void createContIfIndustryIsBankingOnAccount(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        for(Account acc:accList){
            if(acc.Industry=='Banking'){
                Contact cNew=new Contact();
                cNew.AccountId=acc.Id;
                cNew.LastName=acc.Name;
                cNew.Phone=acc.Phone;
                conList.add(cNew);
            }
        }
        insert conList;
    }  
    
    
    //12.Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on 
    //the Account Object.
    public static void contactCreationCountEqualNoOfLocation(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        if(accList[0].NumberofLocations__c>0){
            for(Integer i=1;i<=accList[0].NumberofLocations__c;i++){
                Contact cNew=new Contact();
                cNew.LastName=accList[0].Name+' '+i;
                cNew.AccountId=accList[0].id;
                conList.add(cNew);
            }    
        }
        insert conList; 
    }
    
    
    //17.Whenever a new Account is created with the same name then throw an error i.e. Prevent the users to create Duplicate Accounts
    public static void preventionOfDuplicateAccountCreation(List<Account> accList){
        List<Account> accNameList=[Select Name from Account];
        Set<String> accName=new Set<String>();
        for(Account acc:accNameList){
            accName.add(acc.Name);
        }
        for(Account acc:accList){
            if(accName.contains(acc.Name)){
                acc.addError('Duplicate Account Name cannot be created');
            }
        }
    }
    
    
    //18.Write a trigger in which if an account that has related contacts and the user tries to delete that account it throws you an error 
    //"Account cannot be deleted".    
    public static void accountDeletionPreventionIfContainsContact(List<Account> accList){
        List<Contact> conList=[Select Id,Name,AccountId from Contact where AccountId!=Null];
        Map<Id,Id> accIdToContactIdMap=new Map<Id,Id>();
        for(Contact c:conList){
            accIdToContactIdMap.put(c.AccountId,c.Id);
        }
        for(Account acc:accList){
            if(accIdToContactIdMap.get(acc.Id)!=Null){
                acc.addError('Account cannot be deleted');
            }
        }
    }
    
    //24.Create "Sales Rep" with data type (text) on the Account object. When we create Account records, Account owners will be systematically inserted into 
    //the sales representative field. When we update the record account owner, the sales representative will be systematically updated.
    public static void salesReprPopulatedAutomatically(List<Account> accList){
        List<Id> userId=new List<Id>();
        for(Account acc:accList){
            userId.add(acc.OwnerId);
        }
        List<User> userList=[Select Id,Name from User where Id IN:userId];
        Map<Id,String> userIdToNameMap=new Map<Id,String>();
        for(User u:userList){
            userIdToNameMap.put(u.Id,u.Name);
        }
        for(Account acc:accList){
            acc.Sales_Rep__c=userIdToNameMap.get(acc.OwnerId);
        }
    }  
    
    
    /*26.Write a trigger on the Account when the Account is updated and check all Opportunities related to the Account. Update all 
Opportunities Stage to closed lost if an Opportunity created date is greater than 30 days from today and stage is not equal to close won.*/
    public static void updateOppOnUpdatingAccount(Map<Id,Account> oldMap){
        List<Opportunity> oppList=new List<Opportunity>([Select Id,Name,StageName,CreatedDate,AccountId from Opportunity where AccountId 
                                                         IN:oldMap.keySet() AND CreatedDate>:Date.Today()-30 AND StageName!='Closed Won']);
        for(Opportunity opp:oppList){
            opp.StageName='Closed Lost';
        }
        update oppList;
    }
    
    //27.Write a trigger on Account, when an account is inserted, automatically the account billing address should populate into the account 
    //shipping address.
    public static void populateAccountShippingAddress(List<Account> accList){
        for(Account acc:accList){
            acc.ShippingCity=acc.BillingCity;
            acc.ShippingCountry=acc.BillingCountry;
            acc.ShippingStreet=acc.BillingStreet;
            acc.ShippingPostalCode=acc.BillingPostalCode;
            acc.ShippingState=acc.BillingState;
            
        }
    } 
    
    
    //28"Once an Account is inserted an email should go to the System Admin user with specified text below.
    //An account has been created and the name is ""Account Name""."
    public static void emailOnAccountCreationToSystemAdmin(List<Account> accList){
        Map<Id,Profile> profileIdSystemAdminMap=new Map<Id,Profile>([Select Id,Name from Profile where Name='System Administrator']);
        List<User> adminUser=[Select Id,Name,Email from User where ProfileId IN :profileIdSystemAdminMap.keySet()];
        List<String> emailList=new List<String>();
        for(User u:adminUser){
            emailList.add(u.Email);
        }
        List<Messaging.singleEmailMessage> msgList=new List<Messaging.singleEmailMessage>();
        for(Account acc:accList){
            Messaging.singleEmailMessage msg=new Messaging.singleEmailMessage();
            msg.setToAddresses(emailList);
            msg.setSubject('Account Creation Confirmation');
            msg.setPlainTextBody('An account has been created and the name is '+acc.Name);
            msgList.add(msg);
        }
        Messaging.sendEmail(msgList);
    }
    
    
    //30.Whenever user updates any account's billing address, then update all its child Contact's mail address field same as Account's 
    //billing address.
    public static void updationOfContactMailingAddOnUpdatingAccBillingAdd(List<Account> newListAcc, Map<Id,Account> oldMap){
        Map<Id,Account> idToAccMap=new Map<Id,Account>();
        for(Account acc:newListAcc){
            if(oldMap!=Null && (acc.BillingCity!=oldMap.get(acc.Id).BillingCity || acc.BillingCountry!=oldMap.get(acc.Id).BillingCountry
                                || acc.BillingPostalCode!=oldMap.get(acc.Id).BillingPostalCode || acc.BillingState!=oldMap.get(acc.Id).BillingState 
                                || acc.BillingStreet!=oldMap.get(acc.Id).BillingStreet))
            {
                idToAccMap.put(acc.Id,acc);
            }
        }
        List<Contact> conList=[Select Id,Name,AccountId from Contact where AccountId IN : idToAccMap.keySet()];
        List<Contact> updatedConList=new List<Contact>();
        for(Contact c:conList){
            if(idToAccMap.containsKey(c.AccountId)){
                Contact conObj=new Contact();
                conObj.AccountId=c.AccountId;
                conObj.Id=c.Id;
                conObj.MailingCity=idToAccMap.get(c.AccountId).BillingCity;
                conObj.MailingCountry=idToAccMap.get(c.AccountId).BillingCountry;
                conObj.MailingPostalCode=idToAccMap.get(c.AccountId).BillingPostalCode;
                conObj.MailingState=idToAccMap.get(c.AccountId).BillingState;
                conObj.MailingStreet=idToAccMap.get(c.AccountId).BillingStreet;
                updatedConList.add(conObj);
            }
        }
        update updatedConList;
    }
    
    //33.Create a field on Account named "Client Contact" (lookup to Contact). Once an Account is inserted a Contact will be created with 
    //the name of the Account and that Contact will be the Client Contact on the Account.
    public static void createClientContactOnAccountCreation(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        Set<Id> accId=new Set<Id>();
        for(Account acc:accList){
            Contact c=new Contact();
            c.LastName=acc.Name;
            c.AccountId=acc.Id;
            conList.add(c);
            accId.add(acc.Id);
        }
        insert conList;
        Map<Id,Contact> accIdTocontMap=new Map<Id,Contact>();
        for(Contact c:conList){
            accIdTocontMap.put(c.AccountId,c);
        }
        
        List<Account> updatedAccList=new List<Account>();
        for(Account acc:accList){
            if(accIdTocontMap.containsKey(acc.Id)){
                Account a=new Account();
                a.Id=acc.Id;
                a.Client_Contact__c=accIdTocontMap.get(acc.Id).Id;
                updatedAccList.add(a);
            }
        }
        update updatedAccList;
    } 
    
    //42"Write a trigger on Account when an account is updated when account type changes send an email to all its contacts that your account
    //information has been changed.
    //Subject: Account Update Info
    //Body: Your account information has been updated successfully.
    //Account Name: XYZ."
    public static void sendEmailToAllContactsIfAccountTypeUpdated(List<Account> newAccList,Map<Id,Account> oldMap){
        Set<Id> accIds=new Set<Id>();
        for(Account acc:newAccList){
            if(!oldMap.isEmpty() && acc.Type!=oldMap.get(acc.Id).Type){
                accIds.add(acc.Id);
            }
        }
        List<Contact> conList=[Select Id,Name,AccountId,Email from Contact where AccountId IN:accIds AND Email!=Null];
        Map<Id,Account> accIdToAccountMap=new Map<Id,Account>([Select Id,Name from Account where Id IN:accIds]);
        
        List<Messaging.SingleEmailMessage> msgList=new List<Messaging.SingleEmailMessage>();
        for(Contact c:conList){
            Account acc=accIdToAccountMap.get(c.AccountId);
            Messaging.SingleEmailMessage msg=new Messaging.SingleEmailMessage();
            msg.setToAddresses(new List<String>{c.Email});
            msg.setSubject('Account Update Info');
            msg.setPlainTextBody('Your Account Information is saved Successfully!\nAccount Name:-'+acc.Name);
            msgList.add(msg);
        }
        if(!msgList.isEmpty()){
            Messaging.sendEmail(msgList);
        }
        else{
            System.debug('Error in email sending process.');
        } 
    }
    
    //48.On Account object create a custom field "Status" (picklist - Active & Inactive).On Contact object create a custom field Do 
    //Not Contact (checkbox). Delete all related Opportunities and check Do Not Contact checkbox on related contact when User changes
    //Account status from Active to Inactive. 
    public static void deleteAllRelatedOppANdMarkDoNotContactOnAllContactWhenAccUpdatesActiveToInActive(List<Account> newAccList,Map<Id,Account> oldAccMap){
        Set<Id> accIds=new Set<Id>();
        for(Account acc:newAccList){
            if(acc.Status__c=='Inactive' && oldAccMap.get(acc.Id).Status__c=='Active'){
                accIds.add(acc.Id);
            }
        }
        List<Opportunity> oppList=[Select Id,AccountId from Opportunity where AccountId IN:accIds];
        List<Contact> conList=[Select Id,Do_Not_Contact__c,AccountId from Contact where AccountId IN:accIds];
        List<Opportunity> oppListToDelete=new List<Opportunity>();
        List<Contact> conListToUpdate=new List<Contact>();
        oppListToDelete.addAll(oppList);
        for(Contact c:conList){
            if(accIds.contains(c.AccountId)){
                Contact cUpdate=new Contact();
                cUpdate.Id=c.Id;
                cUpdate.Do_Not_Contact__c=true;
                conListToUpdate.add(cUpdate);
            }
        }
        if(!oppListToDelete.isEmpty()){
            delete oppListToDelete;
        }
        if(!conListToUpdate.isEmpty()){
            update conListToUpdate;
        }
    }                                                                                                            
    
    
    
    
    
    //50.When an account BillingCity is updated, update all its contacts MailingCity with account BillingCity.
    public static void updateMailingCityOfContactOnUpdatingBillingCityOfAcc(List<Account> newListAcc, Map<Id,Account> oldMap){
        Map<Id,Account> idToAccMap=new Map<Id,Account>();
        for(Account acc:newListAcc){
            if(oldMap!=Null && acc.BillingCity!=oldMap.get(acc.Id).BillingCity)
            {
                idToAccMap.put(acc.Id,acc);
            }
        }
        List<Contact> conList=[Select Id,Name,AccountId from Contact where AccountId IN : idToAccMap.keySet()];
        List<Contact> updatedConList=new List<Contact>();
        for(Contact c:conList){
            if(idToAccMap.containsKey(c.AccountId)){
                Contact conObj=new Contact();
                conObj.AccountId=c.AccountId;
                conObj.Id=c.Id;
                conObj.MailingCity=idToAccMap.get(c.AccountId).BillingCity;
                updatedConList.add(conObj);
            }
        }
        update updatedConList;
    }
    
    //73."Create a field on Contact called ""Profile""(text 255)
    //When an Account is updated and the Website is filled in, update all the Profile field on all Contacts to:
    //Profile = Website + ‘/’ + First Letter of First Name + Last Name"
    public static void updateProfileOnAllContactOnUpdatingAccWebsite(List<Account> newAccList, Map<Id,Account> oldMap) {
        Set<Id> accIdSet = new Set<Id>();
        for (Account acc : newAccList) {
            if (oldMap.containsKey(acc.Id) && acc.Website != null && acc.Website != oldMap.get(acc.Id).Website) {
                accIdSet.add(acc.Id);
            }
        }
        
        Map<Id,String> accIdToWebsiteMap = new Map<Id,String>();
        for (Account acc : [SELECT Id, Website FROM Account WHERE Id IN :accIdSet]) {
            accIdToWebsiteMap.put(acc.Id, acc.Website);
        }
        
        List<Contact> updatedContacts = new List<Contact>();
        
        for (Contact c : [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId IN :accIdSet]) {
            String website = accIdToWebsiteMap.get(c.AccountId);
            
            if (website != null) {
                String firstLetter = (c.FirstName != null && c.FirstName.length() > 0) ? c.FirstName.substring(0, 1) : '';
                String lastName = (c.LastName != null) ? c.LastName : '';
                
                c.Profile__c = website + '/' + firstLetter + lastName;
                updatedContacts.add(c);
            }
        }
        
        if (!updatedContacts.isEmpty()) {
            update updatedContacts;
        }
    }
    
    
    //64."Create a field on Account called ""Only_Default_Contact""(checkbox), default off,When a new Account is created, create a new Contact 
    //that has the following data points
    //First Name = ""Info""
    //Last Name = ""Default""
    //Email = ""info@websitedomain.tld""
    //Only_Default_Contact = TRUE
    //When the Account has more than 1 Contact, update Only_Default_Contact to FALSE."
    public static void createNewContactOnAccountCreation(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        List<Account> acc2List=new List<Account>();
        for(Account acc:accList){
            Contact c=new Contact();
            c.LastName='Default';
            c.FirstName='Info';
            c.AccountId=acc.Id;
            c.Email='info@websitedomain.tld';
            Account a=new Account();
            a.Id=acc.Id;
            a.Only_Default_Contact__c=true;
            conList.add(c);
            acc2List.add(a);
        }
        if(!conList.isEmpty()){
            insert conList;
            update acc2List;
        }
    }
    
    //66."Create a field on Account called ""Out_of_Zip""(checkbox), default off.When a Billing Address is modified, get the new Postal Code. 
    //Then check which Contacts on the Account are outside that Postal Code. If 1 or more Contacts are outside of the Postal Code, 
    //mark Out_of_Zip as TRUE."
    public static void markOutOfZipTrueOnAccountIfPostalCodeOfAnyContactOnThatAccHasDifferentZipCode(List<Account> newList,Map<Id,Account> oldMap){
        Set<Id> accId=new Set<Id>();
        for(Account acc:newList){
            if(!oldMap.isEmpty() && acc.BillingPostalCode!=oldMap.get(acc.Id).BillingPostalCode){
                accId.add(acc.Id);
            }
        }
        List<Account> updatedAccList=new List<Account>();
        Map<Id,Account> accMap=new Map<Id,Account>([Select Id,BillingPostalCode from Account where Id IN:accId]);
        Map<id,Account> accToUpdateMap=new Map<id,Account>();
        List<Contact> conList=[Select Id,MailingPostalCode,AccountId from Contact where AccountId IN:accId];
        for(Contact c:conList){
            if(accMap.containsKey(c.AccountId) && c.MailingPostalCode!=accMap.get(c.AccountId).BillingPostalCode){
                
                if(!accToUpdateMap.containsKey(c.AccountId)){
                    Account acc=new Account();
                    acc.Id=c.AccountId;
                    acc.Out_of_Zip__c=true;
                    accToUpdateMap.put(c.AccountId,acc);
                }else{
                    continue;
                }
                
            }
        }
        if(!accToUpdateMap.values().isEmpty()){
            update accToUpdateMap.values();
        }
    }
    
    //68.Write a trigger that stops users from editing an Account record if it was updated in the past hour. If less than one hour has passed since the 
    //last update, show an error message and block the update.
    public static void preventUserFromUpdatingAccountInAnHour(List<Account> newAccList){
        DateTime oneHourAgo=System.now().addHours(-1);
        Map<Id,Account> accMap=new Map<Id,Account>([Select Id from Account where LastModifiedDate>=:oneHourAgo]);
        for(Account acc:newAccList){
            if(accMap.containsKey(acc.Id)){
                acc.addError('Cannot Modify The Account within an hour');
            }
        }
    }
    
    
    //70.Write a trigger to prevent the deletion of related Contacts when their parent Account is deleted.
    public static void preventDeletionOfContactOnRelatedAccountDeletion(List<Account> accList){
        Set<Id> accId=new Set<Id>();
        for(Account acc:accList){
            accId.add(acc.Id);
        }
        List<Contact> conList=[Select Id,AccountId from Contact where AccountId IN:accId];
        for(Contact c:conList){
            c.AccountId=Null;
        }
        update conList;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}