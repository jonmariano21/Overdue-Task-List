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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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

//Compare if one date is greater than another
-(BOOL)isDateGreaterThanDate: (NSDate *)date and: (NSDate *)toDate{
    
    NSTimeInterval dateInterval = [date timeIntervalSince1970];//timeIntervalSince1970 returns the #of seconds since Jan1,1970
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if( dateInterval > toDateInterval ) return YES;
    else return NO;
}

-(void)updateCompletionOfTask: (JMTask *)task forIndexPath: (NSIndexPath *)indexPath{
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey: TASK_OBJECTS_KEY] mutableCopy];
    
    //Check if there was or WASNT an task object saved
    if( !taskObjectsAsPropertyLists ) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists removeObjectAtIndex: indexPath.row];
    
    if(task.isCompleted == YES ) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject: [self taskObjectAsPropertyList: task] atIndex: indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject: taskObjectsAsPropertyLists forKey: TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];//Reload table view
    
}




#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.taskObjects count];//returns the number of elements in our taskObjects MutableArray
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    
    JMTask *task = self.taskObjects[ indexPath.row ];
    
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate: task.date];
    
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate: [NSDate date] and: task.date ];//[NSDate date] returns current date
    
    if( task.isCompleted == YES ) cell.backgroundColor = [UIColor greenColor];
    else if( isOverDue == YES ) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
        
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask: task forIndexPath: indexPath];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;//Yes we can edit the row
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( editingStyle == UITableViewCellEditingStyleDelete ){
        [self.taskObjects removeObjectAtIndex: indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        
        for(JMTask *task in self.taskObjects){
            //Convert task obj arg into a Dictionary and put into our NSMutableArray
            [newTaskObjectsData addObject:[self taskObjectAsPropertyList: task]];//Uses HELPER
        }
        
        //Persist/Save newTaskObjectData array
        [[NSUserDefaults standardUserDefaults] setObject: newTaskObjectsData forKey: TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
}




@end
