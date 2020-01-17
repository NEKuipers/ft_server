<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'nkuipers' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '+tJAT#X2N|yx[{<CyQ.<U6Qi`;i2_?.exuMv)zv&+Lj1z}s%Xv/9+D!|$@}k-31e');
define('SECURE_AUTH_KEY',  'eC$.+9-<_dE{=6$o}+E0IK:4MXTr)V,n*@v&vk&-MCfE,rNd:o6yI*<B]nLyL^D ');
define('LOGGED_IN_KEY',    'E7n@!F8ySYg2 ;2+`,#5yB4&]*v#i9+o|xAmL|U0+jZzt8GukrpxD2izyVrTvm^J');
define('NONCE_KEY',        'PBufqg,mHP~g{q-zDmx36P(+u*|`W</`2V|6aW<x%%2}-%5N.Tz|;>)tW8E3yp=r');
define('AUTH_SALT',        '*Pduy]0fwpm-l+K;/Xy=] k_2x3E&O/J~XdDwv{e1v^ptDfDXg?]J_6[Q7OUNzM*');
define('SECURE_AUTH_SALT', '5/NyCD_o)$[!,n}IrR9s^E|>2>-slrVS0AMA:J&q+$>a$GN2s>AA;Y6AtD8II!<,');
define('LOGGED_IN_SALT',   'cJ9QyO)W-}d;t|qSwtLjFl;Vvut@^et`@3N-L?(Dl2,Kk?}1RLn8Mge{wFO#!u?m');
define('NONCE_SALT',       '^9t7~w<-u{-:-b[>xy+RFa+gr!T}qRB`.~azPt$EV{`l6wrg{id%|)+bQA_0@mR7');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
