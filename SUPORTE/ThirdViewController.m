//
//  ThirdViewController.m
//  SUPORTE
//
//  Created by Victor Antoniazzi on 20/07/12.
//  Copyright (c) 2012 UCPel. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

@synthesize nome;
@synthesize email;
@synthesize body;
@synthesize resposta;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [resposta setText:@""];
	
}

- (IBAction)enviaEmail{
    
    if((nome.text != nil && [nome.text length]) && (email.text != nil && [email.text length]) && (body.text != nil && [body.text length])){
    
        NSMutableString *strURL = [[NSMutableString alloc]initWithFormat:@"http://victor.antoniazzi/insert.php?nome=%@&email=%@&body=%@",nome.text,email.text,body.text];
        
        [strURL setString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
        
        NSMutableString *result = [[NSMutableString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
        
        [resposta setText:result];
        
    }else{
         [resposta setText:@"Preencha todos os campos"];
    }
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
