//
//  dashboardVC.m
//  studentRegistery
//
//  Created by macmini on 2/8/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "dashboardVC.h"
#import "SVProgressHUD.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "API.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "profileVC.h"


@interface dashboardVC (){
    NSString* imgPath;
    UIImage * img1;
    NSEntityDescription *data;
    AppDelegate*app;
    NSArray*studentID,*name;
    NSArray*reslt;
}

@property (nonatomic) UIPopoverController *popover;


@end

@implementation dashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    reslt=[NSArray new];
    
    NSString * temp = [[NSUserDefaults standardUserDefaults]valueForKey:@"CollegeName"];
    NSArray * arr = [temp componentsSeparatedByString:@","];
    NSString * str = [arr objectAtIndex:0];
    NSLog(@"%@",str);
    
    self.navigationItem.title = str;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:117.0/255.0 blue:217.0/255.0 alpha:1.0]];
    
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    data=[NSEntityDescription entityForName:@"PersonalDetail" inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSManagedObjectContext *context =app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"PersonalDetail"];
    NSError *error = nil;
    reslt=[context executeFetchRequest:request error:&error];
    NSLog(@"%@",reslt);
    
    if (reslt.count>0) {
        NSManagedObject*objct=[reslt objectAtIndex:0];
        [self.menuBttn setBackgroundImage:[UIImage imageWithData:[objct valueForKey:@"imagePath"]] forState:UIControlStateNormal];
    }
    
    
    _profName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"FacultyName"];
    //_deptName.text = [NSString stringWithFormat:@"Department: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Department"]] ;
    
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.deptName.text];
//    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(9, self.deptName.text.length-9)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(10, self.deptName.text.length-10)];
//    self.deptName.attributedText=attrString;
    
    NSDateFormatter * dateFrmt = [NSDateFormatter new];
    [dateFrmt setDateFormat:@"dd-MMM-YYYY, cccc"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@    .",[dateFrmt stringFromDate:[NSDate date]]];
//    NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:self.dateLabel.text];
//    [attrString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, self.dateLabel.text.length-6)];
//    self.dateLabel.attributedText=attrString1;
    
    self.radialMenu = [[ALRadialMenu alloc] init];
    self.radialMenu.delegate = self;
    
    self.menuBttn.layer.cornerRadius = self.menuBttn.frame.size.height/2;
    self.menuBttn.layer.masksToBounds = YES;
    self.menuBttn.layer.borderWidth = 1;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.radialMenu buttonsWillAnimateFromButton:self.menuBttn withFrame:self.menuBttn.frame inView:self.view];
    
    
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
    //FIXME: dipshit, change one of these variable names
    if (radialMenu == self.radialMenu) {
        return 6;
    }
    
    return 0;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
    if (radialMenu == self.radialMenu) {
        return 360;
    }
    
    return 0;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
    if (radialMenu == self.radialMenu) {
        return 110;
    }
    
    return 0;
}


- (ALRadialButton *) radialMenu:(ALRadialMenu *)radialMenu buttonForIndex:(NSInteger)index {
    ALRadialButton *button = [[ALRadialButton alloc] init];
    if (radialMenu == self.radialMenu) {
        if (index == 1) {
            [button setImage:[UIImage imageNamed:@"personalTime"] forState:UIControlStateNormal];
        } else if (index == 2) {
            [button setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
        } else if (index == 3) {
            [button setImage:[UIImage imageNamed:@"search-student"] forState:UIControlStateNormal];
        } else if (index == 4) {
            [button setImage:[UIImage imageNamed:@"fullTikme"] forState:UIControlStateNormal];
        } else if (index == 5) {
            [button setImage:[UIImage imageNamed:@"Previous_list"] forState:UIControlStateNormal];
        } else if (index == 6) {
            [button setImage:[UIImage imageNamed:@"takeattndnce"] forState:UIControlStateNormal];
        } 
        
    }
    
    if (button.imageView.image) {
        return button;
    }
    
    return nil;
}


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
    if (index==1) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            personalTableVW * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"personalTableVW"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
         
    }else if (index==2) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            settingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (index==3) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            //exit(0);
            searchStudentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchStudentVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (index==4) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            schdleTableVW * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"schdleTblVw"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (index==5) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            previousEntryList * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"previousEntryList"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (index==6) {
        [self.radialMenu itemsWillDisapearIntoButton:self.menuBttn];
        [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer) {
            autoPeriodVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"autoPeriodVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    
//    if (radialMenu == self.radialMenu) {
//
//    }
    
}

- (BOOL)radialMenu:(ALRadialMenu *)radialMenu shouldRotateMenuButtonWhenItemsAppear:(UIButton *)button {
    if (radialMenu == self.radialMenu) {
        return YES;
    }
    
    return NO;
}

- (BOOL)radialMenu:(ALRadialMenu *)radialMenu shouldRotateMenuButtonWhenItemsDisappear:(UIButton *)button {
    if (radialMenu == self.radialMenu) {
        return NO;
    }
    
    return YES;
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    
    return [UIImageJPEGRepresentation(image,0.1f) base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
}

-(UIImage *)compressImage:(UIImage *)image{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    NSLog(@"Compressed kb:%lu",(unsigned long)imageData.length);
    return [UIImage imageWithData:imageData];
}

- (void)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    if (myStatus==NotReachable) {
        UIAlertController*alert1=[UIAlertController alertControllerWithTitle:@"Network" message:@"There's no internet connection at all." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    }else{
        UIAlertController*alert1=[UIAlertController alertControllerWithTitle:@"Message" message:@"There was a problem with server.So please try again after some time." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
}

- (IBAction)menuAct:(UIButton *)sender {
//    [_menuBttn setImage:[UIImage imageNamed:@"dotClse"] forState:UIControlStateNormal];
//    [NSTimer scheduledTimerWithTimeInterval:0.8 repeats:NO block:^(NSTimer * _Nonnull timer){
//        [self->_menuBttn setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
//    }];
    
//    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You would like to change profile picture." preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
//    UIAlertAction * yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        [self imageAct];
//    }];
//    [alrt addAction:no];
//    [alrt addAction:yes];
//
//    [self presentViewController:alrt animated:YES completion:nil];
    
    profileVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)imageAct{
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * phto = [UIAlertAction actionWithTitle:@"Photo Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoAlbum];
    }];
    
    UIAlertAction * cam = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCamera];
    }];
    
    UIAlertAction * delte = [UIAlertAction actionWithTitle:@"Remove Profile Picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteProfilePicAct];
    }];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alrt addAction:phto];
    [alrt addAction:cam];
    [alrt addAction:delte];
    [alrt addAction:cancle];
    
    [self presentViewController:alrt animated:YES completion:nil];
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    [self.menuBttn setBackgroundImage:croppedImage forState:UIControlStateNormal];
    img1 = [self compressImage:croppedImage];
    
    NSManagedObjectContext *context =app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"PersonalDetail"];
    NSError * error;
    NSArray*rslt=[context executeFetchRequest:request error:&error];
    NSLog(@"the data is %@",rslt);
    
    if (rslt.count>0) {
        NSManagedObject*objct=[rslt objectAtIndex:0];
        NSData*img=UIImagePNGRepresentation(croppedImage);
        [objct setValue:img forKey:@"imagePath"];
        [app.persistentContainer.viewContext save:&error];
    }else{
        NSManagedObject*objct=[[NSManagedObject alloc]initWithEntity:data insertIntoManagedObjectContext:app.persistentContainer.viewContext];
        NSData*img=UIImagePNGRepresentation(croppedImage);
        [objct setValue:@"1" forKey:@"id"];
        [objct setValue:img forKey:@"imagePath"];
        [app.persistentContainer.viewContext save:&error];
    }
    
    
//    [[NSUserDefaults standardUserDefaults]setObject:croppedImage forKey:@"userPic"];
//    _picVW.tag = 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Action methods

- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.menuBttn.currentBackgroundImage;

    UIImage *image = self.menuBttn.currentBackgroundImage;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }

    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - Private methods

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

-(void)deleteProfilePicAct{
    NSManagedObjectContext *context =app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"PersonalDetail"];
    NSError * error;
    NSArray*rslt=[context executeFetchRequest:request error:&error];
    NSLog(@"the data is %@",rslt);
    
    if (rslt.count>0) {
        NSManagedObject*objct=[rslt objectAtIndex:0];
        [app.persistentContainer.viewContext deleteObject:objct];
        [self.menuBttn setBackgroundImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
    }
}

- (void)updateEditButtonEnabled
{
//    if (_picVW.tag==1) {
//        self.editButton.enabled = YES;
//    }else{
//        self.editButton.enabled = NO;
//    }
    
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.menuBttn setBackgroundImage:image forState:UIControlStateNormal];
    img1 = [self compressImage:image];
//    [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"userPic"];
//    _picVW.tag = 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}


@end
