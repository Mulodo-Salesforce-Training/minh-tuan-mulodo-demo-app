public with sharing class InterviewCC {

	public decimal pageSize {get;set;}

	public decimal totalPage {get;set;}

	public final Candidate__c candidate {get;set;}

	

	public InterviewCC() {
		
		Candidate__c[] candidates = [SELECT Name, Email__c, Phone__c, Date_of_Birth__c, Address__c,
										(SELECT Job_Id__c FROM Jobs__r) 
                     				  FROM Candidate__c where Id =: ApexPages.currentPage().getParameters().get('id')];
        if (candidates.size() > 0){
        	candidate = candidates[0];    
        	List<Interview__c> invList = new List<Interview__c>();

			/*for(Interview__c inv : candidate.Jobs__r)
			{
				invList.add(inv);	
			}     
			system.debug(invList);*/    				  
        }
	}


	public Candidate__c getCandidate() {
		return candidate;
	}

	/*public List<Interview__c> getInterviews() {
		List<Interview__c> invList = new List<Interview__c>();

		for(Interview__c inv : candidate.Jobs__r)
		{
			Interview__c[] juncObjects = [SELECT Name, (SELECT Name FROM Candidates__r)
										  FROM Job__c where ]	
		}
		system.debug(invList);
		return invList;
	}*/

	public Map<String, List<Interview__c>> getInterviews() {
		 Map<String,List<Interview__c>> mapC = new  Map<String,List<Interview__c>>();
    		
        	mapC.put(candidate.id, candidate.Jobs__r);
        	return mapC;
	}
}