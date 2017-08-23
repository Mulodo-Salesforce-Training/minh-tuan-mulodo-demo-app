public with sharing class Passed_Candidate_Con {

	public decimal pageNumber {get;set;}

	public decimal pageSize {get;set;}

	public decimal totalPage {get;set;}

	public integer resultSize {get;set;}


	public Passed_Candidate_Con() {
		pageSize = 5.0;
		pageNumber = 1;
		totalPage = 1;
		resultSize = 0;
	}

	public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Name, Email__c, Phone__c, Date_of_Birth__c, Gender__c, Salary__c,
                     (SELECT Job_Id__c FROM Jobs__r) 
                     FROM Candidate__c WHERE Is_Passed__c = true]));
            }

            setCon.setPageSize((integer) pageSize);
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
    }


    public void next()
    {
        setCon.next();
    }

    // Initialize setCon and return a list of records
    public List<Candidate__c> getCandidates() {
    	List<Candidate__c> canList = setCon.getRecords();
    	resultSize = setCon.getResultSize();
    	system.debug('pagesize ' + pageSize);
    	pageNumber = setCon.getPageNumber();
    	if (resultSize == 0)
    	{
    		pageNumber = 0;
    		resultSize = 0;
    	}
    	totalPage = (resultSize / pageSize).round(System.RoundingMode.CEILING);

        return canList;
    }
}