<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', 'ldz13!zeljJeWxzet@zpm' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('AUTH_KEY',         'l*<{RJ`O-LUX48X;[-`eO=|/;f,ml^I ,4rYtR/B$`9.P{fTrh`zA.R}N{F)ArIL');
define('SECURE_AUTH_KEY',  '6CubN<B#YL[/}LGyWti[As+rM: [>g(-V R[*=NI--c8@}*-XS-Xn.gr{AFX9CF]');
define('LOGGED_IN_KEY',    'V]]&PtSbMPRa]/n.jk`cm[O hT;8.fnlhXk;5f)Y, EWW8u85~=,T6B=`rN#N^-Z');
define('NONCE_KEY',        '+mOFKY1;Jb=k}j+Y,tI!D!.0)%|{xS~.I2nKen2_=rt(G2E[It{PVc`C]?,3G%|$');
define('AUTH_SALT',        'c>Z|:QaBu2d[9Bw&PR~*)m/eVn0K!?~/t;l2l0 |X9 `GWz3S1RW)+aZ%kyg//a[');
define('SECURE_AUTH_SALT', 's|cE7:,-=M4H.<yq8k+WM*+M,L&,Cm&-$H4&.g$z7Q=g+@:N,A<:3U1qIf.+oLXa');
define('LOGGED_IN_SALT',   's@=[xZkqJzt EJ>GcqS+yn^*9$)I>;s_hjlk+{J}o-#Cc]WWOPz~:`^N:yY@or|i');
define('NONCE_SALT',       'Q[??[Lm![+*Z 9zTRwJ6fCv-a_/N,A|4dQHF.R8DPc,/?[ulcXX-m.%e8sls+O>#');
$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
