//
//  JMAddTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>

@interface JMAddTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
@end
