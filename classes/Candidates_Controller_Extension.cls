public with sharing class Candidates_Controller_Extension {

	private final Candidate__c mysObject;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public Candidates_Controller_Extension(ApexPages.StandardController stdController) {
        this.mysObject = (Candidate__c)stdController.getRecord();
    }

}