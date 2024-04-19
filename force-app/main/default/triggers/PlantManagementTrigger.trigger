/*trigger PlantManagementTrigger on CAMPX__Plant__c (after insert, after update, after delete) {
    if (Trigger.isInsert || Trigger.isUpdate) {
        PlantTriggerHandler.preDefinedvalue(Trigger.new, Trigger.oldMap);
    }
    
    if (Trigger.isDelete || Trigger.isUpdate) {
        PlantTriggerHandler.updateTotalPlantCount(new List<Plant__c>(), Trigger.oldMap);
    }
}*/

trigger PlantManagementTrigger on CAMPX__Plant__c (after insert, after update, after delete) {
    if (Trigger.isInsert) {
        PlantTriggerHandler.preDefinedvalue(Trigger.new, Trigger.oldMap);
    }
    
    if (Trigger.isUpdate || Trigger.isDelete) {
        PlantTriggerHandler.updateAssociateGarden(Trigger.new, Trigger.oldMap);
    }
}