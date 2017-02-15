//
//  DetailViewController.m
//  MyStuff
//
//  Created by Anatoliy Goodz on 6/15/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "DetailViewController.h"
#import "MyWhatsit.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.nameField.text = [(MyWhatsit*)_detailItem name];
        self.locationField.text = [(MyWhatsit*)_detailItem location];
        self.imageView.image =[(MyWhatsit*)_detailItem image];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changedDetail:(id)aSender
{
    if (aSender == self.nameField)
    {
        [(MyWhatsit *)self.detailItem setName:self.nameField.text];
    }
    else if(aSender == self.locationField)
    {
        [(MyWhatsit *)self.detailItem setLocation:self.locationField.text];
    }
}

- (IBAction)choosePicture:(id)aSender
{
    if (_detailItem == nil)
    {
        return;
    }
    
    BOOL hasPhotos = [UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    assert(hasPhotos);
    
    [self presentImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

- (IBAction)dismissKeyboard:(id)aSender
{
    [self.view endEditing:YES];
}

- (void)presentImagePicker:(UIImagePickerControllerSourceType)aSource
{
    if (aSource == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = aSource;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:aSource];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController *popover = picker.popoverPresentationController;
        if (popover != nil)
        {
            popover.sourceView = self.imageView;
            popover.sourceRect = self.imageView.bounds;
        }
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image != nil)
    {
        self.imageView.image = image;
        [(MyWhatsit *)self.detailItem setImage:image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
