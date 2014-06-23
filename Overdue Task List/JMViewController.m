//
//  JMViewController.m
//  Overdue Task List
//
//  Created by JONATHAN MARIANO on 6/22/14.
//
//

#import "JMViewController.h"

@interface JMViewController ()

@end

@implementation JMViewController

// LAZY INSTANTIATION:
/* The FIRST time we try to access the taskObjects array, this GETTER will be called.
 */
-(NSMutableArray *)taskObjects{
    //If the instance does NOT exist, then we create an instance
    if( !_taskObjects ){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /* Access info from NSUserDefaults:
     * If there is a saved array of info with our task objs into NSUserDefaults, we can access the info
     * and set equal to the arry taskAsPropertyLists
     */
    NSArray *taskAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey: TASK_OBJECTS_KEY];
    
    //Iterate through array
    for( NSDictionary *dictionary in taskAsPropertyLists ){
        JMTask *taskObject = [self convertDictToTask: dictionary];//Uses HELPER
        
        //Add taskObject to our NSArray
        [self.taskObjects addObject: taskObject];
    }
    
    
}


//PREPARE FOR SEGUE
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if( [segue.destinationViewController isKindOfClass: [JMAddTaskViewController class]] ){
        JMAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
    //Create Segue
    
    
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender {
    //Perform Segue
    [self performSegueWithIdentifier: @"toAddTaskViewControllerSegue" sender: nil];
    
}

#pragma mark - JMAddTaskViewController Delegate

-(void)didCancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}//close didCancel method


-(void)didAddTask:(JMTask *)task{
    
    [self.taskObjects addObject: task]; //adding the newly created task from JMAddTaskVC to our JMVC MutableArray
    
    NSLog(@"%@", task.title);
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey: TASK_OBJECTS_KEY] mutableCopy];
    
    if( !taskObjectsAsPropertyLists ) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    //Add a Dictionary to our MutableArray using the HELPER
    [taskObjectsAsPropertyLists addObject: [ self taskObjectAsPropertyList: task] ];
    
    //Save our MutableArray to our NSUserDefaults and replace the old key: TASK_OBJECTS_KEY
    [[NSUserDefaults standardUserDefaults] setObject: taskObjectsAsPropertyLists forKey: TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];//Saves new array
    
    //Dismiss VC when we call the delegate method
    [self dismissViewControllerAnimated:YES completion: nil];
    
    //Reload our tableView to account for new added tasks
    [self.tableView reloadData];
    
}//close didAddTask method

#pragma mark - HELPER

//Convert our Task obj into a Property List Dictionary
-(NSDictionary *)taskObjectAsPropertyList: (JMTask *)taskObject{
    
    NSDictionary *dictionary = @{ TASK_TITLE: taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DATE: taskObject.date, TASK_COMPLETION: @(taskObject.isCompleted) };//@()converts the BOOL of isCompleted to an NSNumber
    
    return dictionary;
}

//Convert Dictionary into a Task OBJ
-(JMTask *)convertDictToTask: (NSDictionary *)dictionary{
    
    JMTask *taskObject = [[JMTask alloc] initWithData: dictionary];//Uses our Custom Initializer

    return taskObject;
    
}




@end
