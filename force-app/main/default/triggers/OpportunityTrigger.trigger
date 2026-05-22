/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 02-25-2026
 * @last modified by  : Sagar
**/
trigger OpportunityTrigger on Opportunity (before insert,after insert,before delete,after delete,before update,after update,after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            //OpportunityTriggerHandler.oppStageModification(Trigger.new,Trigger.oldMap);
            //OpportunityTriggerHandler.preventCreationAndUpdationOfOppInAccWorkingInAsiaAndHave2OrMore(Trigger.new);
        }
        else if(Trigger.isInsert){
            //OpportunityTriggerHandler.preventCreationAndUpdationOfOppInAccWorkingInAsiaAndHave2OrMore(Trigger.new);
            //OpportunityTriggerHandler.preventMultipleOppCreationInADayOrInASingleTransaction(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //OpportunityTriggerHandler.countNumberOfProducts(Trigger.new);
            //OpportunityTriggerHandler.checkAccIsGoldOrNot(Trigger.new);
            //OpportunityTriggerHandler.updateAccountNameWithOppNameHavingHighestAmount(Trigger.new);
            //OpportunityTriggerHandler.closeAllOppInAnAccountHavingProbabilityMoreThan70(Trigger.new);
            //OpportunityTriggerHandler.updateRatingOnAccountBasedOnOppAmount(Trigger.new);
        }
        if(Trigger.isUpdate){
            System.debug('Under Update Trigger----');
            OpportunityTriggerHandler.preventAmountChangeAfterOppIsClosedWon(Trigger.new,Trigger.oldMap);
            List<Id> oppIds = new List<Id>();
            for (Opportunity opp : Trigger.new) {
                Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
                if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                    oppIds.add(opp.Id);
                }
            }
            if (!oppIds.isEmpty()) {
                OpportunityTriggerHandler.updateAccountRevenueOnClosedWonOpp(oppIds);
                //SendDSEnvelope.sendEnvelopeForOpps(oppIds);
            }
            //OpportunityTriggerHandler.updateAccountPicklistValueSameAsOppPicklistValue(Trigger.new,Trigger.oldMap);
            //OpportunityTriggerHandler.checkAccIsGoldOrNot(Trigger.new);
            //OpportunityTriggerHandler.updateAccountNameWithOppNameHavingHighestAmount(Trigger.new);
            //OpportunityTriggerHandler.closeAllOppInAnAccountHavingProbabilityMoreThan70(Trigger.new);
            //OpportunityTriggerHandler.updateClientContactOfAccountOnUpdatingClientContactOfOpp(Trigger.new,Trigger.oldMap);
            //OpportunityTriggerHandler.insertTaskOrUpdateItsDescriptionOnUpdatingOpportunityStage(Trigger.new,Trigger.oldMap);
            //OpportunityTriggerHandler.updateRatingOnAccountBasedOnOppAmount(Trigger.new);
        }
    }
}