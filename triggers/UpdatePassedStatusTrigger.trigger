trigger UpdatePassedStatusTrigger on Interview__c (after insert, after update) {
	Map<Id, Candidate__c> parentObjs = new Map<Id, Candidate__c>();
    List<Id> idList = new List<Id>();
	
    for(Interview__c childObj : Trigger.New){
       	idList.add(childObj.Candidate_Id__c);
    }    
    
    parentObjs = new Map<Id, Candidate__c>([SELECT Id, Is_Passed__c                                            
                                            FROM Candidate__c
                                           	WHERE id in :idList]);
    For(interview__c childObj : Trigger.New){
        Candidate__c parent = parentObjs.get(childObj.Candidate_Id__c);
        parent.Is_Passed__c = childObj.Passed__c;
    }
    
    update parentObjs.values();
}