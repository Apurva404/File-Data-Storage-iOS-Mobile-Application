//
//  ViewController.m
//  DataStorageAssignment
//
//  Created by loaner on 9/12/17.
//  Copyright © 2017 Apurva.Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    NSLog(@"\ndocsDir %@\n", docsDir);
    
    // Build the path to the data archive file
    _dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                       stringByAppendingPathComponent: @"data.archive"]];
    
    NSLog(@"_dataFilePath %@", _dataFilePath);
    
    // Build the path to the data archive file
    dataFile = [docsDir stringByAppendingPathComponent:
                @"datafile.dat"];
    
    NSLog(@"\ndataFile %@\n", dataFile);
    
    
    // Check if the archive file already exists
    if ([filemgr fileExistsAtPath: _dataFilePath])
    {
        NSMutableArray *dataArray;
        
        dataArray = [NSKeyedUnarchiver
                     unarchiveObjectWithFile: _dataFilePath];
        
        _bookname.text = dataArray[0];
        _authorname.text = dataArray[1];
        _descrip.text = dataArray[2];
        
        // Showing toast message after loading from file
        NSString *message = @"Loaded from file succesfully...";
        [self displayToast:message];
        
    
    }
    
    // Check if the file already exists
    else if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *myData;
        myData = [filemgr contentsAtPath: dataFile];

        NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:myData];
        
        _bookname.text = [myDictionary objectForKey:@"bookname"];
        _authorname.text = [myDictionary objectForKey:@"authorname"];
        _descrip.text = [myDictionary objectForKey:@"description"];
        
        // Showing toast message after loading from file
        NSString *message = @"Loaded from file succesfully...";
        [self displayToast:message];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayToast:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    int duration = 3; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (IBAction)saveFile:(id)sender {
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *dataFile;
    
    filemgr = [NSFileManager defaultManager];
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dataFile = [docsDir stringByAppendingPathComponent: @"datafile.dat"];
    NSLog(@"dataFile %@", dataFile);
    
    NSDictionary *myDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         _bookname.text, @"bookname",
                                         _authorname.text, @"authorname",
                                         _descrip.text, @"description",
                                         nil];
    
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:myDictionary];
    
    [filemgr createFileAtPath: dataFile
                     contents: myData attributes:nil];
    
    // Showing toast message after saving file
    NSString *message = @"Saved to file succesfully...";
    [self displayToast:message];
}


- (IBAction)saveArchive:(id)sender {
    NSMutableArray *contactArray;
    
    contactArray = [[NSMutableArray alloc] init];
    [contactArray addObject:_bookname.text];
    [contactArray addObject:_authorname.text];
    [contactArray addObject:_descrip.text];
    [NSKeyedArchiver archiveRootObject:
     contactArray toFile:_dataFilePath];
    
    //Showing toast message after saving file
    NSString *message = @"Saved to archive succesfully...";
    [self displayToast:message];
}

@end




