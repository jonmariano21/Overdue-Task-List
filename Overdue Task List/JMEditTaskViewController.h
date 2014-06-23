//
//  JMEditTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>
#import "JMTask.h"

@protocol JMEditViewControllerDelegate <NSObject>

-(void)didSaveTask;

@end

@interface JMEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <JMEditViewControllerDelegate>delegate;

@property (strong, nonatomic) JMTask *task;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
