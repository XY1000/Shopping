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
    [self.textField becomeFirstResponder];
#pragma mark collectionView
    self.searchCollectionView.delegate = self;
    self.searchCollectionView.dataSource = self;
}

- (IBAction)cancelClicked:(id)sender {
    self.searchViewCancelClickedBlock();
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NetworkService sharedInstance] getSearchResultWithKeyWords:textField.text
                                                         Success:^(NSArray *responseObject) {
                                                             
                                                             self.searchViewReturnClickedBlock(responseObject);
                                                             
                                                         } Failure:^(NSError *error) {
                                                             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error.userInfo[@"errmsg"]]];
                                                         }];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textField resignFirstResponder];
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
