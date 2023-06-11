public with sharing class UpdateOpportunity {


    public static void handleUpdatedAccounts(Id accountsId){
        
    	List<Opportunity> allOpprtunities = new List<Opportunity>();
    	List<Opportunity> willUpdatedOpprtunities = new List<Opportunity>();
        Datetime day30 = system.now()-30;

        allOpprtunities = [Select id,Name,StageName,CloseDate,CreatedDate FROM Opportunity WHERE AccountId =:accountsId];
        System.debug('AccountOpportunity' + allOpprtunities);

        for (Opportunity Opportunity : allOpprtunities) {
            System.debug('Opportunity' + Opportunity);

            if (Opportunity.StageName != 'Closed Won' && Opportunity.CloseDate < day30) {
                System.debug('condation' + Opportunity);

                Opportunity.StageName='Closed Lost';
                Opportunity.CloseDate = system.today();

                willUpdatedOpprtunities.add(Opportunity);

                System.debug('Opp New' + Opportunity.StageName + '   ' + Opportunity.CloseDate);

                          
            }
        }
        update willUpdatedOpprtunities;
        

    }
}