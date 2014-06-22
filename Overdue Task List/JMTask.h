//
//  JMTask.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <Foundation/Foundation.h>

@interface JMTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted; //primitive so may need to WRAP inorder to put into Array/Dictionary

/*
 * Custom Initializer:
 * We are saving this task to core data, so we are converting all of these properties to P-Lists
 * A custom initializer makes this easier
 */
-(id)initWithData: (NSDictionary *)data;


@end
