//
//  IncidenceViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellIncidenceModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface IncidenceViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigation;
@property (weak, nonatomic) IBOutlet UILabel *estado;
@property (weak, nonatomic) IBOutlet UIImageView *imgEstado;
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *municipio;
@property (weak, nonatomic) IBOutlet UIButton *botonIrMapa;
@property (nonatomic, strong) CellIncidenceModel *incidencia;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *labelComent;
@property (weak, nonatomic) IBOutlet UILabel *userComment;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainScroll;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldComment;
@property (weak, nonatomic) IBOutlet UIView *miniSeparator;
@property (weak, nonatomic) IBOutlet UIView *separatorComment;
@property (weak, nonatomic) IBOutlet UILabel *labelUserDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *labelDescripcion;
@property (weak, nonatomic) IBOutlet UIView *spinnerAddComment;
@property (weak, nonatomic) IBOutlet UIButton *goListButton;
@property (weak, nonatomic) IBOutlet UILabel *labelNavigationAux;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *doPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainTopMainView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerImage;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, atomic) ALAssetsLibrary* library;

@property bool ocultarNavigationBar;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)addComment:(id)sender;
- (IBAction)goToList:(id)sender;

- (void) afterGetComments: (NSDictionary*) json;
-(void) afterAddComment: (NSDictionary*) json;
- (void) afterGetImages: (NSDictionary*) json;
-(void) loadImages;
- (void) reloadImages;

- (IBAction)showAddPhoto:(id)sender;
- (IBAction)doPhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)cancelPhoto:(id)sender;

@end
