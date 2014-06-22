//
//  JMViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>

@interface JMViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
