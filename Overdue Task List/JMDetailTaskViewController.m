//
//  JMDetailTaskViewController.m
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import "JMDetailTaskViewController.h"

@interface JMDetailTaskViewController ()

@end

@implementation JMDetailTaskViewController

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
    
    //Setup UIView elements
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    
    //Have to conver date to string using formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate: self.task.date];
    
    self.dateLabel.text = stringFromDate;
    
}


//PREPARE FOR SEGUE
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if( [segue.destinationViewController isKindOfClass: [JMEditTaskViewController class] ]){
        
        JMEditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        editTaskViewController.delegate = self;
        
    }//close if
    
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

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier: @"toEditTaskViewControllerSegue" sender:nil];
    
}


#pragma mark - JMEditViewController Delegate

-(void)didSaveTask{
    
    //Update Labels w/new task info
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate: self.task.date];
    
    self.dateLabel.text = stringFromDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
    
}




@end
