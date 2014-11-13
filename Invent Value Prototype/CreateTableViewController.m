//
//  CreateViewController.m
//  Invent Value Prototype
//
//  Created by Daniel Fairbanks on 8/13/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "CreateTableViewController.h"
#import "Idea.h"
#import "CategoryTableViewController.h"

@interface CreateTableViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, UIActivityItemSource, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *cameraBarButton;
@property (strong,nonatomic) UIActionSheet *myActionSheet;
@property(nonatomic) BOOL clearsOnInsertion;
@property (weak, nonatomic) IBOutlet UILabel *descriptionPlaceholderText;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (strong, nonatomic) NSArray *categoryArray;
@property (weak, nonatomic) IBOutlet CategoryTableViewController *categoryCell;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end

@implementation CreateTableViewController
{
    NSString *_category;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _category = @"No Category";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.categoryArray = [NSArray new];
    
    self.categoryArray = @[@"Business Development", @"Operations", @"Human Resources", @"Marketing", @"Finance", @"Strategy", @"IT", @"Leadership", @"No Category"];
    
    self.categoryPickerView.delegate = self;
    
    if (self.selectedIdea != nil) {
        self.title = @"Edit Checklist";
//        self.textField.text = self.checklistToEdit.name;
//        self.doneBarButton.enabled = YES;
        _category = self.selectedIdea.category;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)CameraButtonPressed:(id)sender {
    self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"Photos" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:@"Take Photo",@"Choose Photo", nil];
    
    [self.myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo"]) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Choose Photo" ]) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else {
        
        return;
        
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return indexPath;
    } else {
        return nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return 50;
    } else if (section == 1){
        return 25;
    } else {
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    } else if (indexPath.section == 1) {
        return 100;
    } else {
        return 44;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return @"Title";
    } else if (section == 1){
        return @"Description";
    } else {
        return @"";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ElevatorPitchCell"];
        
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];

    }
    
    
    
    return cell;
}



#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _categoryArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _categoryArray[row];
}


#pragma mark - Navigation


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//    
//}  // Pass the selected object to the new view controller.

#pragma mark - CategoryTableViewControllerDelegate Methods

-(void)categoryPicker:(CategoryTableViewController *)picker didPickCategory:(NSString *)category {
    _category = category;
    self.categorySelectedLabel.text = _category;
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
