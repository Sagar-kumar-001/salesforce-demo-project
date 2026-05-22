/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 07-15-2025
 * @last modified by  : 
**/
// /**
//  * @description       : SendDSEnvelope is used to send a DocuSign Envelope for a given Opportunity
//  * @param  {List<Id>} : List of Opportunity Ids
//  * @author            : 
//  * @group             : 
//  * @last modified on  : 07-14-2025
//  * @last modified by  : 
// **/


// public with sharing class SendDSEnvelope {
//     @future(callout=true)
//     public static void sendEnvelopeForOpps(List<Id> oppIds) {
//         // Docusign template ID
//         dfsle.UUID templateId = dfsle.UUID.parse('c583bbf0-3c0a-476a-b3f5-70c5a7ab7fe7');
//         List<dfsle.Envelope> toSend = new List<dfsle.Envelope>();

//         for (Opportunity opp : [
//             SELECT Id, AccountId, Client_Contact__c
//             FROM Opportunity
//             WHERE Id IN :oppIds
//         ]) {
//             // Create empty envelope associated to Opportunity
//             dfsle.Envelope env = dfsle.EnvelopeService.getEmptyEnvelope(
//                 new dfsle.Entity(opp.Id));

//             // Retrieve contact info
//             // Contact c = [SELECT Id, Name, Email FROM Contact
//             //              WHERE Id = :opp.Client_Contact__c LIMIT 1];

//             // // Add recipient using template role
//             // dfsle.Recipient rec = dfsle.Recipient.fromSource(
//             //     c.Name, c.Email, null,
//             //     'Owner',  // must match role name in DocuSign template
//             //     new dfsle.Entity(c.Id));

//             // Retrieve contact info
//             Contact c = [SELECT Id, Name, Email FROM Contact
//                          WHERE Id = :opp.Client_Contact__c LIMIT 1];

//             // Add recipient using template role
//             dfsle.Recipient rec = dfsle.Recipient.fromSource(
//                 c.Name, c.Email, null,
//                 'Owner',  // must match role name in DocuSign template
//                 new dfsle.Entity(c.Id));

//             // Get opportunity owner
//             User owner = [SELECT Id, Name, Email FROM User
//                           WHERE Id = :opp.OwnerId LIMIT 1];

//             // Add owner as second recipient (role: Salesperson)
//             dfsle.Recipient ownerRec = dfsle.Recipient.fromSource(
//                 owner.Name, owner.Email, null,
//                 'Salesperson',
//                 new dfsle.Entity(owner.Id)
//             );

//             env = env.withRecipients(new List<dfsle.Recipient>{ rec });

//             // Attach document from template
//             dfsle.Document doc = dfsle.Document.fromTemplate(templateId, 'EnvelopeDoc');
//             env = env.withDocuments(new List<dfsle.Document>{ doc });

//             toSend.add(env);
//         }

//         // Send all envelopes
//         for (dfsle.Envelope e : toSend) {
//             dfsle.EnvelopeService.sendEnvelope(e, true);
//         }
//     }
// }


// public with sharing class SendDSEnvelope {
//     @future(callout=true)
//     public static void sendEnvelopeForOpps(List<Id> oppIds) {
//         // Docusign template ID
//         dfsle.UUID templateId = dfsle.UUID.parse('c583bbf0-3c0a-476a-b3f5-70c5a7ab7fe7');
//         List<dfsle.Envelope> toSend = new List<dfsle.Envelope>();

//         List<Opportunity> oppList = [SELECT Id, AccountId, Client_Contact__c, OwnerId FROM Opportunity WHERE Id IN :oppIds];
//         for (Opportunity opp : oppList) {
//             // Create empty envelope associated to Opportunity
//             dfsle.Envelope env = dfsle.EnvelopeService.getEmptyEnvelope(
//                 new dfsle.Entity(opp.Id));

//             // Retrieve contact info (client)
//             Contact c = [SELECT Id, Name, Email FROM Contact
//                          WHERE Id = :opp.Client_Contact__c LIMIT 1];

//             dfsle.Recipient rec = dfsle.Recipient.fromSource(
//                 c.Name, c.Email, null,
//                 'Owner',  // Must match template role
//                 new dfsle.Entity(c.Id)
//             );

//             // Retrieve Opportunity Owner (Salesperson)
//             User owner = [SELECT Id, Name, Email FROM User
//                           WHERE Id = :opp.OwnerId LIMIT 1];

//             dfsle.Recipient ownerRec = dfsle.Recipient.fromSource(
//                 owner.Name, owner.Email, null,
//                 'Salesperson',  // Must match second template role
//                 new dfsle.Entity(owner.Id)
//             );

//             // 🔧 Add both recipients to envelope
//             env = env.withRecipients(new List<dfsle.Recipient>{ rec, ownerRec });

//             // Attach template document
//             dfsle.Document doc = dfsle.Document.fromTemplate(templateId, 'EnvelopeDoc');
//             env = env.withDocuments(new List<dfsle.Document>{ doc });

//             toSend.add(env);
//         }

//         // 🔁 Send all envelopes
//         for (dfsle.Envelope e : toSend) {
//             dfsle.EnvelopeService.sendEnvelope(e, true);
//         }
//     }
// }


public with sharing class SendDSEnvelope {
    @future(callout=true)
    public static void sendEnvelopeForOpps(List<Id> oppIds) {
        // DocuSign Template ID (replace with actual value)
        dfsle.UUID templateId = dfsle.UUID.parse('e6f6e22d-d393-47d0-a166-36964f1de136');
        List<dfsle.Envelope> toSend = new List<dfsle.Envelope>();

        // Step 1: Query Opportunities
        List<Opportunity> opps = [
            SELECT Id, AccountId, Client_Contact__c, OwnerId
            FROM Opportunity
            WHERE Id IN :oppIds
        ];

        // Step 2: Collect Contact and Owner Ids
        Set<Id> contactIds = new Set<Id>();
        Set<Id> ownerIds = new Set<Id>();

        for (Opportunity opp : opps) {
            if (opp.Client_Contact__c != null) {
                contactIds.add(opp.Client_Contact__c);
            }
            if (opp.OwnerId != null) {
                ownerIds.add(opp.OwnerId);
            }
        }

        // Step 3: Query related Contacts and Users
        Map<Id, Contact> contactMap = new Map<Id, Contact>(
            [SELECT Id, Name, Email FROM Contact WHERE Id IN :contactIds]
        );

        Map<Id, User> ownerMap = new Map<Id, User>(
            [SELECT Id, Name, Email FROM User WHERE Id IN :ownerIds]
        );

        // Step 4: Loop through opportunities and build envelopes
        for (Opportunity opp : opps) {
            Contact c = contactMap.get(opp.Client_Contact__c);
            User owner = ownerMap.get(opp.OwnerId);

            // Skip if required info is missing
            if (c == null || owner == null) {
                continue;
            }

            // Create envelope associated to the Opportunity
            dfsle.Envelope env = dfsle.EnvelopeService.getEmptyEnvelope(
                new dfsle.Entity(opp.Id)
            );

            // Create Recipients using template role names
            dfsle.Recipient rec = dfsle.Recipient.fromSource(
                c.Name, c.Email, null,
                'Owner',  // Must match template role name
                new dfsle.Entity(c.Id)
            );

            dfsle.Recipient ownerRec = dfsle.Recipient.fromSource(
                owner.Name, owner.Email, null,
                'Salesperson',  // Must match template role name
                new dfsle.Entity(owner.Id)
            );

            // Add Recipients and attach document
            env = env.withRecipients(new List<dfsle.Recipient>{ rec, ownerRec });
            dfsle.Document doc = dfsle.Document.fromTemplate(templateId, 'EnvelopeDoc');
            env = env.withDocuments(new List<dfsle.Document>{ doc });

            toSend.add(env);
        }

        // Step 5: Send all envelopes
        for (dfsle.Envelope e : toSend) {
            dfsle.EnvelopeService.sendEnvelope(e, true);
        }
    }
}