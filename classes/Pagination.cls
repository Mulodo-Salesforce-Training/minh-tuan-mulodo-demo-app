public with sharing class Pagination {

    public decimal pageNumber {get;set;}

	public decimal pageSize {get;set;}

	public decimal totalPage {get;set;}

	public integer resultSize {get;set;}

    public string candidateState {get;set;}

    private string query {get;set;}

    private string filter {get;set;}

	public Pagination() {
		pageSize = 5.0;
		pageNumber = 1;
		totalPage = 1;
		resultSize = 0;
        initQuery();
        setFilter();
	}

    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){

                /*setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                	[SELECT Name, Background__c, State__c, Date_of_Birth__c
                     FROM Candidate__c ]));*/

                string filterQuery = query + filter;       
                system.debug(filterQuery);   
                setCon = new ApexPages.StandardSetController(Database.query(filterQuery));
                   
                resultSize = setCon.getResultSize();
                system.debug(resultSize);
            }
            setCon.setPageSize((integer) pageSize);
            return setCon;
        }set;
    }
     
    private void initQuery()
    {
        query = 'SELECT Id, Name, Background__c, State__c, Date_of_Birth__c FROM Candidate__c';
    }

    private void setFilter()
    {
        if (candidateState != null){
            filter = ' Where State__c = \'' + candidateState +'\'';
        }else
        {
            filter = '';
        }
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

    public void interview() {
        candidateState = 'Interview';
        setFilter();
        setCon = null;
    }

    public void Offered() {
        candidateState = 'Offered';
        setFilter();
        setCon = null;
    }

    public void Cancel() {
        candidateState = 'Cancel';
        setFilter();
        setCon = null;
    }

    public void SentOffer() {
        candidateState = 'Sent Offer';
        setFilter();
        setCon = null;
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