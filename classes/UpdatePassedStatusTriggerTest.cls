@isTest
public class UpdatePassedStatusTriggerTest {
    @isTest static void TestUpdatePassedStatus(){
        Candidate__c canc = new Candidate__c(Name='Test', Is_Passed__c = true,
                                             Email__c='a@b.c',Date_of_Birth__c = Date.newInstance(1992, 11, 01),
                                             Source__c='Advertisement',
                                             Gender__c='Male', Experience__c='0 - 1 year',
                                             Phone__c='1234567890'
                                            );
        insert canc;
        Employee__c emp = new Employee__c(Email__c='b.c@d.e');
        insert emp;
        Job__c j = new Job__c(Location__c = 'Others', Job_Category__c='Accounting',
                             Description__c = 'xyz');
        insert j;
        
        Interview__c inv = new Interview__c(Candidate_Id__c = canc.Id, Passed__c = false, Employee_Id__c = emp.Id,
                                           Interview_Date__c = Date.newInstance(2022, 11, 01),
                                            Type__c='Skype',
                                            Job_Id__c = j.Id
                                           );
        
        insert inv;
        
        Interview__c testchild = [Select Id, Passed__c
                                From Interview__c Where Id =: inv.Id];
        
		Candidate__c testParent = [Select Id, Is_Passed__c From Candidate__c where Id =: canc.Id];    
        System.assertEquals(testchild.Passed__c, testParent.Is_Passed__c);
    }
}