public  class GardenHelper {
    Public Static List<Task> createTask (Set<Id> gardenIds){
        List<Task> lstTask = new List<Task>();
        for(CAMPX__Garden__c gr :[SELECT Id,OwnerId,(Select ID,WhatId from Tasks),CAMPX__Manager__c from CAMPX__Garden__c where id in :gardenIds WITH SECURITY_ENFORCED]){
             Task newTask = New Task();
            //if(!(gr.tasks.size()>0)) {
                //Task firstTimeassignment = new Task
               //List<AggregateResult> assignmentCount = [SELECT COUNT(Id) total FROM Task WHERE OwnerId = :gr.OwnerId];
                //System.debug('assignmentCount'+assignmentCount);
                lstTask.add(new Task(Subject = 'Acquire Plants',                                 
                                        WhatId = gr.id,
										OwnerId = gr.CAMPX__Manager__c,
                                        Status = 'Not Started',
                                        Priority = 'Low'));
               
                /*newTask.Subject = 'Acquire Plants';                                 
                newTask.WhatId = gr.id;
                newTask.Status = 'Not Started';
                newTask.Priority = 'Low';
                //if(!(assignmentCount.size()>0)){
                    newTask.OwnerId = gr.CAMPX__Manager__c;
                //}*/
                
            lstTask.add(newTask);
        }
        return lstTask;
    }
}