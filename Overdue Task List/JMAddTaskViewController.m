//
//  JMAddTaskViewController.m
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import "JMAddTaskViewController.h"

@interface JMAddTaskViewController ()

@end

@implementation JMAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HELPER

-(JMTask *)returnNewTaskObject{
    
    JMTask *taskObject = [[JMTask alloc] init];
    taskObject.title = self.textField.text;
    taskObject.description = self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.isCompleted = NO;//The user isnt going to start with a task already completed
    
    return taskObject;
}



- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    
    [self.delegate didAddTask: [self returnNewTaskObject] ];
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate didCancel];
}



@end
