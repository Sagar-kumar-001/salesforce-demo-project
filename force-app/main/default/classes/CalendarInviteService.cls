/**
* @File Name : CalendarInviteService.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 14, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 14, 2025 |   | Initial Version
**/

public class CalendarInviteService {
    public static void sendCalendarInvite(Id recordId) {
        // Example: Get event details dynamically from custom object
        Meeting__c meeting = [SELECT Id, Name, Start_DateTime__c, End_DateTime__c, 
                              Location__c, Description__c, Attendee_Email__c 
                              FROM Meeting__c WHERE Id = :recordId LIMIT 1];

        String organizerEmail = 'sraj20211@gmail.com';
        String attendeeEmail = meeting.Attendee_Email__c;
        String subject = 'Meeting Invite: ' + meeting.Name;
        String body = 'You are invited to a meeting. Please see the attached calendar invite.';
        
        // Format dates in UTC for iCalendar
        String startUtc = meeting.Start_DateTime__c.formatGMT('yyyyMMdd\'T\'HHmmss\'Z\'');
        String endUtc = meeting.End_DateTime__c.formatGMT('yyyyMMdd\'T\'HHmmss\'Z\'');
        String uid = meeting.Id + '@yourcompany.com';
        
        // Construct ICS file content
        String icsContent = 'BEGIN:VCALENDAR\n' +
            'VERSION:2.0\n' +
            'PRODID:-//Salesforce//Calendar Invite//EN\n' +
            'METHOD:REQUEST\n' +
            'BEGIN:VEVENT\n' +
            'UID:' + uid + '\n' +
            'SUMMARY:' + meeting.Name + '\n' +
            'DTSTART:' + startUtc + '\n' +
            'DTEND:' + endUtc + '\n' +
            'LOCATION:' + (meeting.Location__c != null ? meeting.Location__c : '') + '\n' +
            'DESCRIPTION:' + (meeting.Description__c != null ? meeting.Description__c : '') + '\n' +
            'STATUS:CONFIRMED\n' +
            'ORGANIZER;CN=Salesforce:' + organizerEmail + '\n' +
            'ATTENDEE;CN=Recipient;RSVP=TRUE:mailto:' + attendeeEmail + '\n' +
            'END:VEVENT\n' +
            'END:VCALENDAR';

        // Create attachment
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('meeting-invite.ics');
        attachment.setBody(Blob.valueOf(icsContent));
        attachment.setContentType('text/calendar; charset=UTF-8; method=REQUEST');

        // Create email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { attendeeEmail });
        email.setSubject(subject);
        email.setPlainTextBody(body);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
        email.setUseSignature(false);

        // Send email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}