public class LeadTriggerHandler {
    //2.Whenever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
    	public static void setLeadRating(List<Lead> leadList){
        	for(Lead newLead:leadList){
            	if(newLead.LeadSource=='Web'){
                	newLead.Rating='Cold';
            	}
            	else{
                	newLead.Rating='Hot';
            	}
        	}
    	}

    //22.Write a trigger on lead to prevent duplicate records based on lead email, if a record already created with the same Email, 
    //Or record is Updated. The trigger should throw an error.
    public static void checkDuplicateLead(List<Lead> listOfLead){
        List<Lead> leadList=[Select Id,Email from Lead];
        Set<String> email=new Set<String>();
        for(Lead l:leadList){
            email.add(l.Email);
        }
        
        for(Lead l:listOfLead){
            if(l.Email!=Null){
                if(email.contains(l.Email)){
                    l.addError('Email Id already exists.');
                }
            }
        }
    }
    
   
    
    //37."Upload any pdf file into Document first. Send an email as an attachment to the lead email Id when a lead is created.
    //Email Subject: Welcome
    //Body: Please find the attached PDF."
    public static void emailToLeadEmailOnLeadCreation(List<Lead> leadList){
        List<String> emailList=new List<String>();
        List<Messaging.singleEmailMessage> msgList=new List<Messaging.singleEmailMessage>();
        for(Lead l:leadList){
            emailList.add(l.Email);
        }
        Id docList=[Select Id from Document where Name='Apex Script-2.docx.pdf'].Id;  
        for(Lead l:leadList){
            Messaging.singleEmailMessage msg=new Messaging.singleEmailMessage();
            msg.setToAddresses(emailList);
            msg.setSubject('Welcome');
            msg.setPlainTextBody('Please find the attached PDF.');
            msg.setEntityAttachments(new List<String>{docList});
            msgList.add(msg);
        }
        Messaging.sendEmail(msgList);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}