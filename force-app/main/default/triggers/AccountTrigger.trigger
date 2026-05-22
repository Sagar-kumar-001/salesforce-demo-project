trigger AccountTrigger on Account (before insert,after insert,after delete,before delete,after update,before update) {
    AccountTriggerHandler handler=new AccountTriggerHandler();
    if(Trigger.isBefore && Trigger.isInsert){
        handler.OnBeforeInsert(Trigger.new);
        //AccountTriggerHandler.createRating(Trigger.new);
        //AccountTriggerHandler.errorOnAccountCreation(Trigger.new);
        //AccountTriggerHandler.preventionOfDuplicateAccountCreation(Trigger.new);
        //AccountTriggerHandler.salesReprPopulatedAutomatically(Trigger.new);
        //AccountTriggerHandler.populateAccountShippingAddress(Trigger.new);
        //AccountTriggerHandler.emailOnAccountCreationToSystemAdmin(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //AccountTriggerHandler.createContact(Trigger.new);
        //AccountTriggerHandler.AccountContactPhoneRelated(Trigger.New);
        //AccountTriggerHandler.createRelatedOppOnAccount(Trigger.new);
        //AccountTriggerHandler.createContIfIndustryIsBankingOnAccount(Trigger.new);
        //AccountTriggerHandler.contactCreationCountEqualNoOfLocation(Trigger.new);
        //AccountTriggerHandler.updationOfContactMailingAddOnUpdatingAccBillingAdd(Trigger.oldMap);
        //AccountTriggerHandler.createClientContactOnAccountCreation(Trigger.new);
        //AccountTriggerHandler.createNewContactOnAccountCreation(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        //AccountTriggerHandler.confirmationEmailOnAccountDeletion(Trigger.old);
    }
    
    if(Trigger.isBefore && Trigger.isDelete){
        //AccountTriggerHandler.preventionOfActiveAccountDeletion(Trigger.old);
        //AccountTriggerHandler.accountDeletionPreventionIfContainsContact(Trigger.old);
        //AccountTriggerHandler.preventDeletionOfContactOnRelatedAccountDeletion(Trigger.old);
    }
   
    if(Trigger.isAfter && Trigger.isUpdate){
        //AccountTriggerHandler.updateContPhoneOnUpdatingAccPhone(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.updateOppOnUpdatingAccount(Trigger.oldMap);
        //AccountTriggerHandler.updationOfContactMailingAddOnUpdatingAccBillingAdd(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.updateMailingCityOfContactOnUpdatingBillingCityOfAcc(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.updateProfileOnAllContactOnUpdatingAccWebsite(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.sendEmailToAllContactsIfAccountTypeUpdated(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.deleteAllRelatedOppANdMarkDoNotContactOnAllContactWhenAccUpdatesActiveToInActive(Trigger.new,Trigger.oldMap);
        //AccountTriggerHandler.markOutOfZipTrueOnAccountIfPostalCodeOfAnyContactOnThatAccHasDifferentZipCode(Trigger.new, Trigger.oldMap);
    }
	
    if(Trigger.isBefore && Trigger.isUpdate){
    	//AccountTriggerHandler.updatingPhoneOnAccount(Trigger.new,Trigger.oldMap);
    	//AccountTriggerHandler.salesReprPopulatedAutomatically(Trigger.new);
    	//AccountTriggerHandler.preventUserFromUpdatingAccountInAnHour(Trigger.new);
    }
    
}