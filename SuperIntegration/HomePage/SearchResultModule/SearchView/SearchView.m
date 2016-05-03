//
//  SearchView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SearchView.h"

@interface SearchView()<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchResultNavBarViewTextFieldWidthLayoutConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@end

@implementation SearchView

- (void)awakeFromNib {
    [self.searchResultNavBarViewTextFieldWidthLayoutConstraint setConstant:SearchButtonWidth];
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    [self.textField becomeFirstResponder];
#pragma mark collectionView
    self.searchCollectionView.delegate = self;
    self.searchCollectionView.dataSource = self;
}

- (IBAction)cancelClicked:(id)sender {
    self.searchViewCancelClickedBlock();
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.searchViewReturnClickedBlock(0,textField.text);
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
    [self removeFromSuperview];
}

#pragma mark collectionView

static NSString * const reuseIdentifier = @"Cell";

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


@end
