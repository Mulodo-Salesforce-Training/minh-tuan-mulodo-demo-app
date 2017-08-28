public with sharing class CandidatesPhotoUploadCC {

    Private Static FINAL String fixedFileName = 'profilePhoto.jpg';

    public boolean displaying { get; set; }
    public Candidate__c pageCandidate;
    public transient Blob profilePicFile { get; set; }
    public Id currentPicture { get; set; }
    
    /** Constructor, grab record, and check/load an existing photo */
    public CandidatesPhotoUploadCC(ApexPages.StandardController controller) {
        pageCandidate = (Candidate__c)controller.getRecord();
        
        List<attachment> currentPictures = [SELECT Id FROM Attachment WHERE parentId = :pageCandidate.Id AND name = :fixedFileName LIMIT 1];
        if(currentPictures.size() != 0) {
            currentPicture = currentPictures.get(0).Id;
        }
        
        displaying = true;
    }

    /** toggle switches between the photo display and photo upload form */
    public void toggle() {
        displaying = !displaying;
    }
    
    /** saveFile clears any existing profile picture, retrieves the data from the form, and saves it under the relevant filename*/
    Public Pagereference saveFile() {

        // first, we cannot have any conflicting files
        List<attachment> savedPicture = [SELECT Id, name, body FROM Attachment WHERE parentId = :pageCandidate.Id AND name = :fixedFileName];
        if(savedPicture.size() > 0) {
            delete savedPicture;
        }
       
        // Now, we save the new blob
        Attachment a = new Attachment(parentId = pageCandidate.Id, name = fixedFileName, body = profilePicFile);
        insert a;
        
        currentPicture = a.Id;
        
        displaying = true;
        return null;
    }
    

}