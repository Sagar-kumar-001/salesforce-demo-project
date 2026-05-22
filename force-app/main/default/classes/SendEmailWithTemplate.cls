public class SendEmailWithTemplate {
    public static void sendEmail(){
        EmailTemplate temp = [SELECT Id,Subject,Body FROM EmailTemplate WHERE DeveloperName = 'testEmailTemplate' limit 1];
        Contact con = [Select Id,Name,Email from Contact where Name = 'Sagar' limit 1];
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(new List<String>{con.Email});
        message.setTemplateId(temp.Id);
        message.setTargetObjectId(con.Id);
        emailList.add(message);
		Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
    }
}