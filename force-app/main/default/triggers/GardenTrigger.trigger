trigger GardenTrigger on CAMPX__Garden__c ( after insert, after update, before insert, before update) {
    GardenTriggerHandler handler = new GardenTriggerHandler();
    if (Trigger.isAfter && GardenTriggerHandler.isFirstTime) {
        if (Trigger.isInsert) {
            GardenTriggerHandler.preDefinedvalue(Trigger.new);
        }
        else if (Trigger.isUpdate) {
           // GardenTriggerHandler.isFirstTime = false;
           // GardenTriggerHandler.preDefinedvalue(Trigger.new);
        }
    }
    if(Trigger.isBefore){
        
    }
}