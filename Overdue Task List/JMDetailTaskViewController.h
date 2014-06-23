//
//  JMDetailTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>
#import "JMTask.h"
#import "JMEditTaskViewController.h"

@protocol JMDetailViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface JMDetailTaskViewController : UIViewController <JMEditViewControllerDelegate>//Conform to protocol

@property (weak, nonatomic) id <JMDetailViewControllerDelegate>delegate;

@property (strong, nonatomic) JMTask *task;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
