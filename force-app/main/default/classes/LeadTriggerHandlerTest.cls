@isTest
public class LeadTriggerHandlerTest {

    @isTest
    static void setLeadRatingTest() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            Lead newLead = new Lead();
            newLead.LastName = 'Test Lead ' + i;
            newLead.LeadSource = 'Web'; // Should set Rating = 'Cold'
            newLead.Company='sdf';
            leadList.add(newLead);
        }
        
        System.Test.startTest();
        insert leadList;

        // Fetch leads from database
        List<Lead> fetchedLeads = [SELECT Id, Rating FROM Lead WHERE Id IN :leadList];
        
        // Validate all Leads with LeadSource='Web' have Rating='Cold'
        System.assertEquals(5, fetchedLeads.size(), 'Not all leads were inserted!');
        for (Lead l : fetchedLeads) {
            System.assertEquals('Cold', l.Rating, 'Lead rating should be Cold for Web leads.');
        }

        // Insert a Lead with a different LeadSource
        Lead otherLead = new Lead(LastName = 'Test Other', LeadSource = 'Phone Enquiry',Company='edv');

        insert otherLead;
        System.Test.stopTest();

        // Fetch the newly inserted lead and validate Rating
        Lead fetchedOtherLead = [SELECT Id, Rating FROM Lead WHERE Id = :otherLead.Id];
        System.assertEquals('Hot', fetchedOtherLead.Rating, 'Lead rating should be Hot for non-Web leads.');
    }
    
    
    //22.Write a trigger on lead to prevent duplicate records based on lead email, if a record already created with the same Email, 
    //Or record is Updated. The trigger should throw an error.
    @isTest
    static void checkDuplicateLeadOnInsertionTest(){
        Lead l=new Lead();
        l.LastName='Test lead';
        l.Company='Test Company';
        l.Status='Open - Not Contacted';
        l.Email='abc1@gmail.com';
        insert l;
        
        Lead l1=new Lead();
        l1.LastName='Test lead';
        l1.Company='Test Company';
        l1.Status='Open - Not Contacted';
        l1.Email='abc1@gmail.com';
        Database.SaveResult res=Database.insert(l1,false);
        
        System.assert(!res.isSuccess());
    }
    
    @isTest
    static void checkDuplicateLeadOnUpdateTest(){
        Lead l=new Lead();
        l.LastName='Test lead';
        l.Company='Test Company';
        l.Status='Open - Not Contacted';
        l.Email='abc1@gmail.com';
        insert l;
        
        Lead l1=new Lead();
        l1.LastName='Test lead';
        l1.Company='Test Company';
        l1.Status='Open - Not Contacted';
        l1.Email='abc12@gmail.com';
        insert l1;
        
        Lead l2=[Select Id,Email from Lead where Id=:l1.Id];
        l2.Email='abc1@gmail.com';
        Database.SaveResult res=Database.update(l2,false);
        System.assert(!res.isSuccess());
    }
}