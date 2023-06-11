@isTest
private class UpdateOpportunity_Test {

    @isTest
    static void testHandleUpdatedAccounts() {
        // Create a test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create opportunities for testing
        Opportunity opportunity1 = new Opportunity(
            Name = 'Opportunity 1',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(-15),
            AccountId = testAccount.Id
        );
        Opportunity opportunity2 = new Opportunity(
            Name = 'Opportunity 2',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(-45),
            AccountId = testAccount.Id
        );

        // Insert the opportunities
        insert new List<Opportunity>{opportunity1, opportunity2};

        // Call the method under test
        Test.startTest();
        UpdateOpportunity.handleUpdatedAccounts(testAccount.Id);
        Test.stopTest();

        // Retrieve the updated opportunities
        List<Opportunity> updatedOpportunities = [SELECT StageName, CloseDate FROM Opportunity WHERE AccountId = :testAccount.Id];

        // Verify the changes in the updated opportunities
        System.assertEquals('Closed Lost', updatedOpportunities[0].StageName);
        System.assertEquals(Date.today(), updatedOpportunities[0].CloseDate);

        // Verify that the closed won opportunity was not updated
        System.assertNotEquals('Closed Lost', updatedOpportunities[1].StageName);
        System.assertNotEquals(Date.today(), updatedOpportunities[1].CloseDate);
    }

}