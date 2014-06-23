//
//  JMEditTaskViewController.m
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import "JMEditTaskViewController.h"

@interface JMEditTaskViewController ()

@end

@implementation JMEditTaskViewController

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
    
    self.textField.text = self.task.title;
    self.textView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.textField.delegate = self;
    self.textView.delegate = self;
    
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

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [self updateTask];
    [self.delegate didSaveTask];
    
}

//HELPER: updates task properties with what we type in the EditVC
-(void)updateTask{
    self.task.title = self.textField.text;
    self.task.description = self.textView.text;
    self.task.date = self.datePicker.date;
    
}



#pragma mark - UITextField & UITextView Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.textField resignFirstResponder];
    return YES; //b/c we want user to be able to use return key
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString: @"\n"]){
        [self.textView resignFirstResponder];
        return NO;
        
    }
    return YES;
    //NOTE: Assuming user is NOT pasting the return character into textView!!!!! HAcky Solution
    
}



@end
