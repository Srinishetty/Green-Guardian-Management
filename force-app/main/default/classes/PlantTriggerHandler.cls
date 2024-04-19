/*public with sharing class PlantTriggerHandler {
    
    public static void preDefinedvalue(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldMap)) {
        List<CAMPX__Plant__c> plantsToUpdate = new List<CAMPX__Plant__c>(); // Separate collection for update
        
        Set<Id> plantIds = new Set<Id>();
        for (CAMPX__Plant__c pt : lstPlant) {
            plantIds.add(pt.Id);
        }
        
        for (CAMPX__Plant__c cPlant : [SELECT Id, CAMPX__Soil_Type__c, CAMPX__Water__c, CAMPX__Sunlight__c, CAMPX__Garden__r.CAMPX__Sun_Exposure__c 
                                        FROM CAMPX__Plant__c 
                                        WHERE Id IN :plantIds]) {
            // Apply predefined values if necessary
            if (cPlant.CAMPX__Soil_Type__c == null) {
                cPlant.CAMPX__Soil_Type__c = 'All Purpose Potting Soil';
            }
            if (cPlant.CAMPX__Water__c == null) {
                cPlant.CAMPX__Water__c = 'Once Weekly';
            }
            if (cPlant.CAMPX__Sunlight__c == null) {
                if (cPlant.CAMPX__Garden__r != null && cPlant.CAMPX__Garden__r.CAMPX__Sun_Exposure__c != null) {
                    cPlant.CAMPX__Sunlight__c = cPlant.CAMPX__Garden__r.CAMPX__Sun_Exposure__c;
                } else {
                    cPlant.CAMPX__Sunlight__c = 'Partial Sun';
                }
            }
            plantsToUpdate.add(cPlant); // Add plant to update collection
        }
        
        // Update plantsToUpdate
        if (!plantsToUpdate.isEmpty()) {
            update plantsToUpdate;
        }
    }
    
    public static void updateTotalPlantCount(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldMap) {
        // List to hold the IDs of the gardens to be updated
        Set<Id> gardenIdsToUpdate = new Set<Id>();
        
        // Logic to handle insertion or update of plant records
        for (CAMPX__Plant__c plant : newPlants) {
            if (plant.CAMPX__Garden__c != null) {
                gardenIdsToUpdate.add(plant.CAMPX__Garden__c);
            }
        }
        
        // Logic to handle deletion or update of plant records
        for (CAMPX__Plant__c plant : oldMap.values()) {
            if (plant.CAMPX__Garden__c != null) {
                gardenIdsToUpdate.add(plant.CAMPX__Garden__c);
            }
        }
        
        // Update total plant count for gardens
        List<CAMPX__Garden__c> gardensToUpdate = [SELECT Id, CAMPX__Total_Plant_Count__c, (SELECT Id FROM CAMPX__Plants__r ) FROM CAMPX__Garden__c WHERE Id IN :gardenIdsToUpdate];
        
        for (CAMPX__Garden__c  garden : gardensToUpdate) {
            garden.CAMPX__Total_Plant_Count__c = garden.CAMPX__Plants__r.size();
        }
        
        // Update gardens
        update gardensToUpdate;
    }
}*/

public with sharing class PlantTriggerHandler {
    
    public static void preDefinedvalue(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldMap) {
        List<CAMPX__Plant__c> plantsToUpdate = new List<CAMPX__Plant__c>(); // Separate collection for update
        
        Set<Id> plantIds = new Set<Id>();
        for (CAMPX__Plant__c pt : newPlants) {
            plantIds.add(pt.Id);
        }
        
        for (CAMPX__Plant__c cPlant : [SELECT Id, CAMPX__Soil_Type__c, CAMPX__Water__c, CAMPX__Sunlight__c, CAMPX__Garden__r.CAMPX__Sun_Exposure__c 
                                        FROM CAMPX__Plant__c 
                                        WHERE Id IN :plantIds]) {
            // Apply predefined values if necessary
            if (cPlant.CAMPX__Soil_Type__c == null) {
                cPlant.CAMPX__Soil_Type__c = 'All Purpose Potting Soil';
            }
            if (cPlant.CAMPX__Water__c == null) {
                cPlant.CAMPX__Water__c = 'Once Weekly';
            }
            if (cPlant.CAMPX__Sunlight__c == null) {
                if (cPlant.CAMPX__Garden__r != null && cPlant.CAMPX__Garden__r.CAMPX__Sun_Exposure__c != null) {
                    cPlant.CAMPX__Sunlight__c = cPlant.CAMPX__Garden__r.CAMPX__Sun_Exposure__c;
                } else {
                    cPlant.CAMPX__Sunlight__c = 'Partial Sun';
                }
            }
            plantsToUpdate.add(cPlant); // Add plant to update collection
        }
        
        // Update plantsToUpdate
        if (!plantsToUpdate.isEmpty()) {
            update plantsToUpdate;
        }
    }
    
    public static void updateAssociateGarden(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldMap) {
        // List to hold the IDs of the gardens to be updated
        Set<Id> gardenIdsToUpdate = new Set<Id>();
        
        // Logic to handle insertion or update of plant records
        if(newPlants != null){
            for (CAMPX__Plant__c plant : newPlants) {
                if (plant.CAMPX__Garden__c != null) {
                    gardenIdsToUpdate.add(plant.CAMPX__Garden__c);
                }
            }            
        }

        // Logic to handle deletion or update of plant records
        for (CAMPX__Plant__c plant : oldMap.values()) {
            if (plant.CAMPX__Garden__c != null) {
                gardenIdsToUpdate.add(plant.CAMPX__Garden__c);
            }
        }
        
        // Update total plant count for gardens
        List<CAMPX__Garden__c> gardensToUpdate = [SELECT Id, CAMPX__Total_Plant_Count__c, CAMPX__Total_Unhealthy_Plant_Count__c, (SELECT Id,CAMPX__Status__c FROM CAMPX__Plants__r ) FROM CAMPX__Garden__c WHERE Id IN :gardenIdsToUpdate];
        
        for (CAMPX__Garden__c  garden : gardensToUpdate) {
            Integer totalUnhealthyCount = 0;
            garden.CAMPX__Total_Plant_Count__c = garden.CAMPX__Plants__r.size();
            for(CAMPX__Plant__c plant : garden.CAMPX__Plants__r){
                if(plant.CAMPX__Status__c =='Sick' || plant.CAMPX__Status__c  =='Deceased' || plant.CAMPX__Status__c =='Wilting'){
                    totalUnhealthyCount += 1;
                }
            }
             garden.CAMPX__Total_Unhealthy_Plant_Count__c = totalUnhealthyCount;
        } 
        // Update gardens
        update gardensToUpdate;
        
    }
}