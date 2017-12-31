//
//  ViewController.m
//  PTFS
//
//  Created by Qiang Ju on 12/27/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "ViewController.h"
#import "helper.h"
#import "project.h"
#import "Team.h"
#import "Dashboard.h"
#import "Widget.h"

@interface ViewController ()
- (IBAction)btnConnectClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtServer;
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //_Id    __NSCFString *    @"6869be47-66d9-41de-ad24-9b83b67791aa"    0x00000001c0077bc0
    // Dispose of any resources that can be recreated._Id    __NSCFString *    @"c955f4f8-3b05-4afc-9969-3a54f7b70533"    0x00000001c406bb80
}


- (IBAction)btnConnectClicked:(id)sender {
    [Helper Login:_txtServer.text username:_txtUser.text password:_txtPass.text success:^(NSString *response) {
        NSMutableArray* prjlist = [Project getList];
        for(int i=0;i<prjlist.count;i++){
            NSLog(@"Project:%@", ((Project*)prjlist[i]).Name);
                /*NSMutableArray* teamlist = [Team getListByProjectID:((Project*)prjlist[i]).Id];
                for(int j=0;j<teamlist.count;j++){
                    NSLog(@"\tTeam:%@", ((Team*)teamlist[j]).Name);
                    NSMutableArray* dblist = [Dashboard getListByProjectID:((Project*)prjlist[i]).Id TeamID:((Team*)teamlist[j]).Id];
                    for(int k=0;k<dblist.count;k++){
                        NSLog(@"\t\tDashboard:%@, %@", ((Dashboard*)dblist[k]).Name,
                              ((Dashboard*)dblist[k]).URL
                              );
                        NSLog(@"\t\tDashboard:%d",k);
                    }
                }*/
            NSMutableArray* dblist = [Dashboard getFormalListByProjectID:((Project*)prjlist[i]).Name];
            for(int k=0;k<dblist.count;k++){
                NSLog(@"\tDashboard:%@, %@", ((Dashboard*)dblist[k]).Name,
                      ((Dashboard*)dblist[k]).URL
                      );
                [Widget getListByDashboard:((Dashboard*)dblist[k]).URL];
                NSLog(@"\tDashboard:%d",k);
            }
            NSLog(@"---------------------------");
        }
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Conguration" message:response preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:
         [UIAlertAction
          actionWithTitle:@"OK"
          style:UIAlertActionStyleDefault
          handler:nil
          ]
         ];
        [self presentViewController:alert animated:true completion:nil];
    } failure:^(NSError *error) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:
         [UIAlertAction
          actionWithTitle:@"OK"
          style:UIAlertActionStyleDefault
          handler:nil
          ]
         ];
        [self presentViewController:alert animated:true completion:nil];
    } ];
}
@end
