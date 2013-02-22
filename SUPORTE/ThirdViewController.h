//
//  ThirdViewController.h
//  SUPORTE
//
//  Created by Victor Antoniazzi on 20/07/12.
//  Copyright (c) 2012 UCPel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController

- (IBAction)enviaEmail;

@property(nonatomic,retain) IBOutlet UITextField *nome;
@property(nonatomic,retain) IBOutlet UITextField *email;
@property(nonatomic,retain) IBOutlet UITextField *body;

@property(nonatomic,retain) IBOutlet UILabel *resposta;



@end
