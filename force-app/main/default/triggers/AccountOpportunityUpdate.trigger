trigger AccountOpportunityUpdate on Account (after update) {
// Created 8-6-2023

    if (Trigger.isAfter && Trigger.isUpdate) {

        UpdateOpportunity.handleUpdatedAccounts(Trigger.new[0].Id);
        System.debug('Account' + Trigger.new[0].Id);
    }


}