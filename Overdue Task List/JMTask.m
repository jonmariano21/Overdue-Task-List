//
//  JMTask.m
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import "JMTask.h"

@implementation JMTask

/* Implement the custom initializer:
 * so it returns an instance of self with all of its’ properties set from the dictionary parameter (data)
 * Use the #defines setup in your .pch file as the keys to access values from the data parameter. 
 * Make sure the default initializer, -(id)init, implements the new designated initializer.
 */
-(id)initWithData: (NSDictionary *)data{
    
    /* This instance of JMTask will use the super class's (NSObject) initializer first,
     * before it adds its own custom functionality onto this initializer.
     */
    self = [super init];
    
    /* Set the Task properties to the NSDictionary parameter (data) */
    if( self ){
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];//wrapper b/c cant have primitives in Dictionary
    }
    
    return self;
}
/* Make sure the default initializer, -(id)init, implements the new designated initializer.*/
-(id)init{
    
    self = [self initWithData: nil];
    return self;
    
}

@end
