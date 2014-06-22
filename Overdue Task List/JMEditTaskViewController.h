//
//  JMEditTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>

@interface JMEditTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
