//
//  JMDetailTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>

@interface JMDetailTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
