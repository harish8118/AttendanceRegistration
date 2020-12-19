//
//  profileVC.m
//  AttendanceRegistration
//
//  Created by macmini on 9/4/19.
//  Copyright © 2019 CST Pvt Ltd. All rights reserved.
//

#import "profileVC.h"
#import "Reachability.h"
#import "AFNetworking.h"


@interface profileVC (){
    AppDelegate*app;
    NSEntityDescription *data;
    NSArray*reslt;
    UIImage * img1;
}
@property (nonatomic) UIPopoverController *popover;

@end

@implementation profileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    data=[NSEntityDescription entityForName:@"PersonalDetail" inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSManagedObjectContext *context =app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"PersonalDetail"];
    NSError *error = nil;
    reslt=[context executeFetchRequest:request error:&error];
    NSLog(@"%@",reslt);
    
    if (reslt.count>0) {
        NSManagedObject*objct=[reslt objectAtIndex:0];
        self.prflpic.image = [UIImage imageWithData:[objct valueForKey:@"imagePath"]];
        
        self.prflpic.layer.cornerRadius = self.prflpic.frame.size.height/2;
        self.prflpic.layer.masksToBounds = YES;
        self.prflpic.layer.borderWidth = 1.0;
        
    }
    
    self.totalBar.progressBarCornerRadius = 5.0;
    [self.totalBar setPercentagePosition:M13ProgressViewBarPercentagePositionRight];
    [self.totalBar setShowPercentage:YES];
//    self.totalBar.animateStripes = YES;
//    self.totalBar.showStripes = YES;
//    self.totalBar.cornerType = M13ProgressViewStripedBarCornerTypeRounded;
    [self.totalBar performAction:M13ProgressViewActionNone animated:YES];
    [self.totalBar setProgress:1.0 animated:YES];
    
    self.attendBar.progressBarCornerRadius = 5.0;
    [self.attendBar setPercentagePosition:M13ProgressViewBarPercentagePositionRight];
    [self.attendBar setShowPercentage:YES];
//    self.attendBar.animateStripes = YES;
//    self.attendBar.showStripes = YES;
//    self.attendBar.cornerType = M13ProgressViewStripedBarCornerTypeRounded;
    [self.attendBar performAction:M13ProgressViewActionSuccess animated:YES];
    [self.attendBar setProgress:.76 animated:YES];
    
    self.absentBar.progressBarCornerRadius = 5.0;
    [self.absentBar setPercentagePosition:M13ProgressViewBarPercentagePositionRight];
    [self.absentBar setShowPercentage:YES];
//    self.failedBar.animateStripes = YES;
//    self.failedBar.showStripes = YES;
//    self.failedBar.cornerType = M13ProgressViewStripedBarCornerTypeRounded;
    [self.absentBar performAction:M13ProgressViewActionFailure animated:YES];
    [self.absentBar setProgress:.24 animated:YES];
    

    
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

- (IBAction)photoAct:(UIButton *)sender {
    UIAlertController * alrt = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You would like to change profile picture." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction * yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self imageAct];
    }];
    [alrt addAction:no];
    [alrt addAction:yes];
    
    [self presentViewController:alrt animated:YES completion:nil];

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
    
    self.prflpic.image = croppedImage;
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
        self.prflpic.image = [UIImage imageNamed:@"profile"];
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
    self.prflpic.image = image;
    img1 = [self compressImage:image];
    //    [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"userPic"];
    //    _picVW.tag = 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        //[self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            //[self openEditor:nil];
        }];
    }
}
@end
