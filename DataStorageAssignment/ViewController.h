//
//  ViewController.h
//  DataStorageAssignment
//
//  Created by Apurva on 9/12/17.
//  Copyright © 2017 Apurva.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic)IBOutlet UILabel *filestorage;
@property (weak, nonatomic) IBOutlet UITextField *bookname;
@property (weak, nonatomic) IBOutlet UITextField *authorname;
@property (weak, nonatomic) IBOutlet UITextField *descrip;
@property (strong, nonatomic) NSString *dataFilePath;
@property (weak, nonatomic) IBOutlet UIButton *savefileButton;
@property (weak, nonatomic) IBOutlet UIButton *saveArchiveButton;

- (IBAction)saveFile:(id)sender;
- (IBAction)saveArchive:(id)sender;


@end

