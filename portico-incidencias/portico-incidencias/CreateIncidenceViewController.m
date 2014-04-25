//
//  CreateIncidenceViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 21/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "CreateIncidenceViewController.h"
#import "LocationHelper.h"
#import "IncidenceModel.h"
#import "UserHelper.h"
#import "IncidenceViewController.h"
#import "ListIncidencesViewController.h"

@interface CreateIncidenceViewController ()

@end

@implementation CreateIncidenceViewController

NSMutableArray  * imageArray;

NSMutableArray  * imageAuxArray;
NSMutableArray  * buttonAuxArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *colorPlaceHolder = [[UIColor alloc]initWithRed:(205/255.0) green:(205/255.0) blue:(202/255.0) alpha:1.0];
   
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height +20)];
    [v setBackgroundColor: [[UIColor alloc]initWithRed:(74/255.0) green:(60/255.0) blue:(49/255.0) alpha:1.0]];
    [self.view addSubview:v];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
    
    
    self.labelNavigation.text = NSLocalizedString(@"###newIncidence###", nil);
    [self.createButtom setTitle:NSLocalizedString(@"###doIt###", nil) forState:UIControlStateNormal];
    self.incidenceTitle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###incidenceTitle###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
    self.incidenceDescription.text = NSLocalizedString(@"###incidenceDescription###", nil);
    
     self.latitud.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###latitude###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
     self.longitud.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###longitude###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
    [self.addImageButton setTitle:NSLocalizedString(@"###addPhoto###", nil) forState:UIControlStateNormal];
    [self.locateButton setTitle:NSLocalizedString(@"###currentLocation###", nil) forState:UIControlStateNormal];
    
    [self.doPhotoButton setTitle:NSLocalizedString(@"###doPhoto###", nil) forState:UIControlStateNormal];
    [self.selectPhotoButton setTitle:NSLocalizedString(@"###selectFoto###", nil) forState:UIControlStateNormal];
    [self.cancelButton setTitle:NSLocalizedString(@"###cancel###", nil) forState:UIControlStateNormal];
    
    self.incidenceDescription.delegate = self;
    self.incidenceTitle.delegate = self;
    self.incidenceDescription.delegate = self;
    self.latitud.delegate = self;
    self.longitud.delegate = self;
    
    [self.photoView removeFromSuperview];
    [self.photoView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = self.photoView.frame;
    frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
    self.photoView.frame = frame;
    [self.view addSubview:self.photoView];
    
    imageArray = [[NSMutableArray alloc]init];
    imageAuxArray = [[NSMutableArray alloc]init];
    buttonAuxArray = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Nos damos de alta en la notificación del teclado para adaptar la Text View
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyboardWillAppear:(NSNotification *)notification {
    
    //if ([self.latitud isFirstResponder] || [self.longitud isFirstResponder]) {
    [self.mainView setAlpha:1.0];
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.constrainScroll.constant += keyboardRect.size.height;
    
    //}
}

-(void)keyboardWillDisappear:(NSNotification *)notification {
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.constrainScroll.constant -= keyboardRect.size.height;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]) {
        self.incidenceDescription.text = @"";
        self.incidenceDescription.textColor = [[UIColor alloc]initWithRed:(110/255.0) green:(99/255.0) blue:(90/255.0) alpha:1.0];
    }
    [self.incidenceDescription becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.incidenceDescription.text isEqualToString:@""]) {
        self.incidenceDescription.text = NSLocalizedString(@"###incidenceDescription###", nil);
        self.incidenceDescription.textColor = [[UIColor alloc]initWithRed:(205/255.0) green:(202/255.0) blue:(199/255.0) alpha:1.0];
    }
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTouched:(id)sender {
    [self.incidenceTitle resignFirstResponder];
    [self.incidenceDescription resignFirstResponder];
    [self.latitud resignFirstResponder];
    [self.longitud resignFirstResponder];
    
    [self cancelPhotoAnimation:sender];
    
    
}

- (IBAction)getCurrenLocation:(id)sender {
    [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
}

- (void) afterGetCurrentLocation: (CLLocation*) currentLocation{
    self.latitud.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.latitude] ;
    self.longitud.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.longitude] ;
}

- (IBAction)createIncidence:(id)sender {
    if(![self.incidenceTitle.text isEqualToString:@""] && (![self.incidenceDescription.text isEqualToString:@""] || [self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]) && ![self.latitud.text isEqualToString:@""] && ![self.longitud.text isEqualToString:@""]){

        [self.spinner setHidden:false];
        [self backgroundTouched:sender];
        
          NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.incidenceTitle.text, @"titulo", self.incidenceDescription.text, @"descripcion", @"0", @"estado", [[UserHelper getInstance]getUsuario], @"id_user", self.latitud.text, @"latitud", self.longitud.text, @"longitud", nil];
        
        [IncidenceModel createIncidence:@selector(afterCreateIncidence:) fromObject:self parameters:parameters];

    }else{
        NSString *error = @"";;
        if([self.incidenceTitle.text isEqualToString:@""]){
            error = @"La incidencia debe tener un título.";
            
        }else if([self.incidenceDescription.text isEqualToString:@""] || [self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]){
            error = @"La incidencia debe tener una descripción.";
            
        }else{
           error = @"La incidencia debe estar localizada. Complete los campos latitud y longitud.";
            
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete los campos obligatorios"
                                                        message:error
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //[IncidenceModel addImages:@selector(afterPrueba:) fromObject:self parameters:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Value1",@"Key1",nil] images:imageArray];
}

- (IBAction)showPhotoPanel:(id)sender {
    
    [self backgroundTouched:sender];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];

    [self.photoView removeFromSuperview];
    [self.photoView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = self.photoView.frame;
    frame.origin.y = 435;
    self.photoView.frame = frame;
    [self.view addSubview:self.photoView];
    
    [self.mainView setAlpha:0.2];
    
    [UIView commitAnimations];
    
   
}

- (IBAction)cancelPhotoAnimation:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [self cancelPhoto];
    [UIView commitAnimations];
}

- (void) cancelPhoto{
   
    [self.photoView removeFromSuperview];
    [self.photoView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = self.photoView.frame;
    frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
    self.photoView.frame = frame;
    [self.view addSubview:self.photoView];
    
    [self.mainView setAlpha:1.0];
}

- (IBAction)doPhoto:(id)sender {
    // Creo el View Controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Nos declaramos su delegado
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    [self cancelPhoto];
}

- (IBAction)selectPhoto:(id)sender {

    // Creo el View Controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // Nos declaramos su delegado
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    [self cancelPhoto];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CGRect frame;
    /*[self.addImageButton removeFromSuperview];
    [self.addImageButton setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.addImageButton.frame;
    frame.size.width = 35;
    self.addImageButton.frame = frame;
    [self.imagenContentView addSubview:self.addImageButton];*/
    
    [self.imageViewScroll setHidden:false];
    
    UIImage *imagenCapturada = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    frame = self.imageView.frame;
    frame.origin.x += [imageArray count] * (frame.origin.x + self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15) + 15;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:imagenCapturada];
    [self.imagenContentView addSubview:imageView];
    
    frame = self.imageViewButton.frame;
    frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width;
    UIButton *imageViewButton = [[UIButton alloc]initWithFrame:frame];
    //Para que no tenga el mismo tag que la imagen
    imageViewButton.tag = [imageArray count] + 10;
    [imageViewButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageViewButton setImage:self.imageViewButton.imageView.image forState:UIControlStateNormal];
    [self.imagenContentView addSubview:imageViewButton];
    
    [imageArray addObject:imagenCapturada];
    [imageAuxArray addObject:imageView];
    [buttonAuxArray addObject:imageViewButton];
    
    if([imageArray count] > 3){
       // self.constrainScrollImages.constant += self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15;
        self.constrainImageContentView.constant += self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void) deleteImage: (UIButton*)sender {
    
    CGRect frame;
    UIImageView *imageAux;
    UIButton *buttonAux;
    
    for (long i=0; i<[imageArray count]; i++) {
        
        if( i == (sender.tag-10)){
            imageAux = [imageAuxArray objectAtIndex:i];
            [imageAux removeFromSuperview];
            
            buttonAux = [buttonAuxArray objectAtIndex:i];
            [buttonAux removeFromSuperview];
            
        }
        else if(i > (sender.tag-10)){
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelay:0.0];
            
            imageAux = [imageAuxArray objectAtIndex:i];
            [imageAux removeFromSuperview];
            frame = imageAux.frame;
            frame.origin.x -= (self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15);
            imageAux.frame = frame;
            [self.imagenContentView addSubview:imageAux];
            
            buttonAux = [buttonAuxArray objectAtIndex:i];
            [buttonAux removeFromSuperview];
            frame = buttonAux.frame;
            frame.origin.x = imageAux.frame.origin.x + imageAux.frame.size.width;;
            buttonAux.frame = frame;
            buttonAux.tag -= 1;
            [self.imagenContentView addSubview:buttonAux];
            
            [UIView commitAnimations];
        }
        
    }
    
    [imageArray removeObjectAtIndex:sender.tag-10];
    [imageAuxArray removeObjectAtIndex:sender.tag-10];
    [buttonAuxArray removeObjectAtIndex:sender.tag-10];
    
    if([imageArray count] == 0){
        [self.imageViewScroll setHidden:true];
    }
    
    if([imageArray count] <= 3){
        //self.constrainScrollImages.constant = 0;
        self.constrainImageContentView.constant = 274;
    }else{
        //self.constrainScrollImages.constant -= (self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15);
        self.constrainImageContentView.constant -= (self.imageView.frame.size.width + self.imageViewButton.frame.size.width + 15);
    }
    
}

- (void) afterCreateIncidence: (NSDictionary*) json{
    
    [self.spinner setHidden:true];
    NSDictionary* result = [json objectForKey:@"result"];
    
    IncidenceViewController *incidenceView = [self.storyboard instantiateViewControllerWithIdentifier:@"IncidenceViewController"];
    
    CellIncidenceModel *incidencia = [[CellIncidenceModel alloc]init];
    
    [incidencia setTituloIncidencia:[[UILabel alloc]init]];
    [incidencia.tituloIncidencia setText:[result objectForKey:@"titulo"]];
    
    [incidencia setMunicipioIncidencia:[[UILabel alloc]init]];
    [incidencia.municipioIncidencia setText:[result objectForKey:@"nombre_municipio"]];
    
    [incidencia setDescripcion:[result objectForKey:@"descripcion"]];
    [incidencia setUser:[result objectForKey:@"id_user"]];
    
    [incidencia setIdIncidencia:[NSNumber numberWithInt:[[result objectForKey:@"id_incidencia"] intValue]]];
    [incidencia setEstado:[result objectForKey:[result objectForKey:@"estado"]]];
    
    [incidenceView setIncidencia:incidencia];

    incidenceView.ocultarNavigationBar = true;
    [self.navigationController pushViewController:incidenceView animated:YES];
}

- (void) afterPrueba: (NSDictionary*) json
{
    int a = 8;
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"awdadwa" style:UIBarButtonItemStylePlain target:nil action:nil];
}*/

@end
