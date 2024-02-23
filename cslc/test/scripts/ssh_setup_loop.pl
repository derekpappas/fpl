#!/usr/bin/perl

for (my $i = 1; $i < 14; $i++ ) {
        print("scp ~/.ssh/id_dsa.pub dpappas\@fpl64-$i.fplsrl.com:.ssh/authorized_keys\n");
        system("scp ~/.ssh/id_dsa.pub dpappas\@fpl64-$i.fplsrl.com:.ssh/authorized_keys\n");
        my $sshCmd = "ssh  dist_regress\@fpl64-$i.fplsrl.com -p 22";
        print("$sshCmd chmod 700 ~/.ssh\n");
        system("$sshCmd chmod 700 ~/.ssh\n");
        print("$sshCmd chmod 600 ~/.ssh/authorized_keys\n");
        system("$sshCmd chmod 600 ~/.ssh/authorized_keys\n");
        print("$sshCmd\n");
        system("$sshCmd  exit\n");
}
