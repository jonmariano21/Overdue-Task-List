//
//  JMViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>
#import "JMAddTaskViewController.h"

@interface JMViewController : UIViewController <JMAddTaskViewControllerDelegate>//conform to protocol, now have access to methods defined in JMAddTaskVC

@property (strong, nonatomic) NSMutableArray *taskObjects; //Mutable Array b/c we are adding/deleting tasks

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
