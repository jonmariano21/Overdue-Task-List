//
//  JMAddTaskViewController.h
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import <UIKit/UIKit.h>
#import "JMTask.h"

@protocol JMAddTaskViewControllerDelegate <NSObject>

-(void)didCancel; //implement both methods in JMViewController.m so that the JMAddTaskVC Class can call back to JMVC
-(void)didAddTask:(JMTask *)task;//Will have to create a JMTask obj in JMAddTaskVC.m use a HELPER

@end

@interface JMAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <JMAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
@end
