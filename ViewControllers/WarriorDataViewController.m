//
//  WarriorDataViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "WarriorDataViewController.h"
#import "WarriorDataView.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "Warrior.h"

@interface WarriorDataViewController ()

@end

@implementation WarriorDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeController:)]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData:)]];

    if (!self.warrior) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:kTxtFieldNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if ([(UITextField*)note.object text].length > 0) {
            [weakSelf.navigationItem.rightBarButtonItem setEnabled:YES];
        }
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.warrior) {
        WarriorDataView *warriorView =  (WarriorDataView*)self.view;
        warriorView.nameTextField.text = self.warrior.name;
        warriorView.surNameTextField.text = self.warrior.surname;
        [warriorView.dobPicker setDate:self.warrior.dob];
        NSUInteger currencyIndex = [warriorView.currencies indexOfObject:self.warrior.currency];
        warriorView.selectedCurrency = warriorView.currencies[currencyIndex];
        [warriorView.currencyPicker selectRow:currencyIndex inComponent:0 animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    self.view = [WarriorDataView new];
}


#pragma mark UIActions
-(void)closeController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveData:(id)sender{
    WarriorDataView *dataView = (WarriorDataView*)self.view;
    NSString *name = dataView.nameTextField.text;
    NSString *surname = dataView.surNameTextField.text;
    NSDate *dob = dataView.dobPicker.date;
    NSString *currency = dataView.selectedCurrency;
    
    NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];

  
    NSDictionary *data = @{@"name":name, @"surname":surname, @"dob":dob,@"currency":currency};
    NSLog(@"data %@", data);
    
    if (!self.warrior) {
        [CoreDataStack createWarriorWithData:data inContext:context];
    }else{
      BOOL updateSuccessfully = [CoreDataStack updateWarrior:self.warrior.objectID withData:data inContext:context];
        if (updateSuccessfully) {
            NSLog(@"Save ok");
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
