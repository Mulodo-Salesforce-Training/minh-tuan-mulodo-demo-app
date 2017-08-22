public with sharing class Passed_Candidate_Con {

	public List<Candidate__c> allCandidates {get;set;}

	public List<Candidate__c> candidatesToShow {get;set;}

	public decimal pageNumber {get;set;}

	public decimal pageSize {get;set;}

	public decimal totalPage {get;set;}


	public Passed_Candidate_Con() {
		allCandidates = new List<Candidate__c>();
		pageSize = 5.0;
		pageNumber = 1;
		totalPage = 1;
	}

	public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Name, Email__c, Phone__c, Date_of_Birth__c, Gender__c, Salary__c,
                     (SELECT Job_Id__c FROM Jobs__r) 
                     FROM Candidate__c WHERE Is_Passed__c = true]));
                system.debug('pagesize ' + pageSize);
                setCon.setPageSize((integer) pageSize);
            }
            return setCon;
        }
        set;
    }

     public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }

    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }

    public void previous()
    {
        setCon.previous();
        totalPage --;
    }


    public void next()
    {
        setCon.next();
        totalPage ++;
    }

    // Initialize setCon and return a list of records
    public List<Candidate__c> getCandidates() {
    	List<Candidate__c> canList = setCon.getRecords();
    	
    	totalPage = (setCon.getResultSize() / pageSize).round(System.RoundingMode.CEILING);
    	system.debug('pagesize: ' + pageSize);
    	system.debug('totalPage: ' + totalPage);

        return canList;
    }
}