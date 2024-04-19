public with sharing class GardenTriggerHandler {
    
    public static Boolean isFirstTime = true;
    
   // public static void preDefinedvalue(List<CAMPX__Garden__c> newGardens, Map<Id, CAMPX__Garden__c> oldGardensMap) {
  public static void preDefinedvalue(List<CAMPX__Garden__c> newGardens) {
        List<Task> tasksToInsert = new List<Task>();
        List<CAMPX__Garden__c> gardensToUpdate = new List<CAMPX__Garden__c>(); // Separate collection for update
        
        Set<Id> gardenWithManager = new Set<Id>();
        
        if(newGardens !=null){
            for (CAMPX__Garden__c garden : [SELECT Id,OwnerId,CAMPX__Status__c,CAMPX__Max_Plant_Count__c,CAMPX__Minimum_Plant_Count__c,CAMPX__Total_Plant_Count__c,CAMPX__Total_Unhealthy_Plant_Count__c,CAMPX__Manager__c from CAMPX__Garden__c where id in :newGardens]) {    
                    if (String.isBlank(garden.CAMPX__Status__c)) {
                        garden.CAMPX__Status__c = 'Awaiting Resources';
                    }
                    if (garden.CAMPX__Max_Plant_Count__c == null) {
                        garden.CAMPX__Max_Plant_Count__c = 100;
                    }
                    if (garden.CAMPX__Minimum_Plant_Count__c == null) {
                        garden.CAMPX__Minimum_Plant_Count__c = 1;
                    }
                    if (garden.CAMPX__Total_Plant_Count__c == null) {
                        garden.CAMPX__Total_Plant_Count__c = 0;
                    }
                    if (garden.CAMPX__Total_Unhealthy_Plant_Count__c == null) {
                        garden.CAMPX__Total_Unhealthy_Plant_Count__c = 0;
                    }
                   /* if (!String.isBlank(garden.CAMPX__Manager__c)) {
                    	gardenWithManager.add(garden.Id);
                	}*/
                //}

                gardensToUpdate.add(garden); // Add garden to update collection
            }
        }
        // Loop through newGardens to apply predefined values and check for manager changes
   
        // Update gardensToUpdate
        if (!gardensToUpdate.isEmpty()) {
            database.update(gardensToUpdate);
        }
        
        /*// Create tasks if necessary
        if (!gardenWithManager.isEmpty()) {
            tasksToInsert = GardenHelper.createTask(gardenWithManager); // Call helper class to create a tasks
        }
        
        // Insert tasks
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }*/
    }
}