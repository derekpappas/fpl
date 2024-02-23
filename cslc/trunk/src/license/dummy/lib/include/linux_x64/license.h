/******************************************************************************

	    COPYRIGHT (c) 2005, 2008 by Reprise Software, Inc.
	This software has been provided pursuant to a License Agreement
	containing restrictions on its use.  This software contains
	valuable trade secrets and proprietary information of 
	Reprise Software Inc and is protected by law.  It may not be 
	copied or distributed in any form or medium, disclosed to third 
	parties, reverse engineered or used in any manner not provided 
	for in said License Agreement except with the prior written 
	authorization from Reprise Software Inc.

 *****************************************************************************/
/*	
 *	Description: 	RLM external definitions
 *
 *	M. Christiano
 *	11/19/05
 *
 */

#ifndef RLM_LICENSE_H_INCLUDED
#define RLM_LICENSE_H_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

#define RLM_VERSION 4
#define RLM_REVISION 0
#define RLM_BUILD 4

#define RLM_SOFTWARE_VERSION  "Reprise License Manager (RLM) v4.0, Copyright (C) 2006-2008, Reprise Software, Inc."
#define RLM_COPYRIGHT  "Copyright (C) 2006-2008, Reprise Software, Inc. All rights reserved"

typedef struct rlm_license *RLM_LICENSE;
typedef struct rlm_handle *RLM_HANDLE;
typedef struct rlm_isv_config *RLM_ISV_CONFIG_HANDLE;
typedef struct rlm_products *RLM_PRODUCTS;

#define RLM_MAX_LINE	  1024	/* Maximum size of a LF line (after */
						/* all continuations */
#define RLM_MAX_PRODUCT     40	/* Max length of a product name */
#define RLM_MAX_VER         10	/* Max length of a version string vvvvvv.rrr */
#define RLM_MAX_ISV	    10	/* Maximum ISV name length */
#define	RLM_ERRSTRING_MAX  512	/* string passed to rlm_errstring() */
					/* 256 for error, 256 for extended */
#define RLM_MAX_LOG	   256	/* Max length of a log string */
#define RLM_MAX_HOSTNAME    64	/* Max length of a license server hostname */
#define RLM_MAX_USERNAME    32	/* Max length of a username */
/*
 *	Hostid string length
 */
#define RLM_MAX_HOSTID  RLM_MAX_HOSTNAME	/* Max length of hostid data */
#define RLM_MAX_HID_KEYWORD_LEN	10	/* Max length of a hostid type keyword */
#define RLM_MAX_HOSTID_STRING  (RLM_MAX_HOSTID+RLM_MAX_HID_KEYWORD_LEN+2)

/*
 *	Hostid types
 */
#define RLM_HOSTID_NONE	  0	/* No hostid specified, e.g. empty string 
				   passed to rlm_get_id() - new in v3.0BL4 */
#define RLM_HOSTID_32BIT  1
#define RLM_HOSTID_STRING 2	/* Equivalent to ANY, ie, works anywhere */
#define RLM_HOSTID_ETHER  3
#define RLM_HOSTID_USER	  4	/* User= */
#define RLM_HOSTID_HOST	  5 	/* Host= */
#define RLM_HOSTID_IP	  6	/* IP address */
#define RLM_HOSTID_ANY	  7	/* ANY - valid anywhere */
#define RLM_HOSTID_DEMO	  8	/* DEMO - valid anywhere */
#define RLM_HOSTID_INVALID 9	/* INVALID hostid - new in v3.0BL4 */
#define RLM_ISV_HID_TYPE_MIN 1000 /* Minimum type value for ISV-def hostid */
#define RLM_MAX_ISVDEF 32	/* Max length of an ISV-defined field */

/* 
 *	License types, from type= keyword
 */

#define RLM_LA_BETA_TYPE	0x1
#define RLM_LA_EVAL_TYPE	0x2
#define RLM_LA_DEMO_TYPE	0x4

/* 
 *	License sharing definitions, from share= keyword
 */

#define RLM_LA_SHARE_USER 1		/* Share if username matches */
#define RLM_LA_SHARE_HOST 2		/* Share if hostname matches */
#define RLM_LA_SHARE_ISV  4		/* Share if isv-defined matches */

/*
 *	Function prototypes
 */
extern int			rlm_add_isv_hostid(RLM_HANDLE, const char *, 
							int, int, int (*)());
extern int			rlm_add_isv_hostid_multiple(RLM_HANDLE, 
							const char *, int, int, 
							int (*)(), int (*)());
extern char **			rlm_all_hostids(RLM_HANDLE, int);
extern void			rlm_all_hostids_free(char **);
extern int			rlm_auto_hb(RLM_HANDLE, int, int,
					void (*func)(RLM_HANDLE, RLM_LICENSE));
extern int			rlm_checkin(RLM_LICENSE);
extern struct rlm_license * 	rlm_checkout(RLM_HANDLE, const char *, 
							const char *, int);
extern int			rlm_close(RLM_HANDLE);
extern char *			rlm_errstring(RLM_LICENSE, RLM_HANDLE, char *);
extern void			rlm_forget_isv_down(RLM_HANDLE);
extern int			rlm_get_attr_health(RLM_LICENSE);
extern char *			rlm_get_attr_lfpath(RLM_LICENSE);
extern const char *		rlm_hostid(RLM_HANDLE, int, char *);
extern struct rlm_handle *	rlm_init(const char *, const char *, 
								const char *);
extern void			rlm_isv_cfg_set_license(RLM_HANDLE, 
								const char *);
extern int			rlm_isv_cfg_set_name(RLM_HANDLE, const char *);
extern void			rlm_isv_cfg_set_use_flexlm_lockfile(RLM_HANDLE, 
							int);
extern int			rlm_log(RLM_HANDLE, const char *);
extern int			rlm_dlog(RLM_HANDLE, const char *);
extern int			rlm_sign_license(RLM_HANDLE rh, int encode_bits,
					  char *server_hostid, char *license);
extern void			rlm_skip_isv_down(RLM_HANDLE);

/*
 *	RLM_LICENSE data
 */

extern char *			rlm_license_contract(RLM_LICENSE lic);
extern char *			rlm_license_customer(RLM_LICENSE lic);
extern char *			rlm_license_exp(RLM_LICENSE lic);
extern int			rlm_license_exp_days(RLM_LICENSE lic);
extern int 			rlm_license_goodonce(RLM_LICENSE lic);
extern int 			rlm_license_hold(RLM_LICENSE lic);
extern char * 			rlm_license_hostid(RLM_LICENSE lic);
extern char *			rlm_license_issued(RLM_LICENSE lic);
extern char *			rlm_license_issuer(RLM_LICENSE lic);
extern int 			rlm_license_max_roam(RLM_LICENSE lic);
extern int 			rlm_license_max_share(RLM_LICENSE lic);
extern int 			rlm_license_min_timeout(RLM_LICENSE lic);
extern int 			rlm_license_named_user_count(RLM_LICENSE lic);
extern int 			rlm_license_named_user_min_hours(
							RLM_LICENSE lic);
extern char *			rlm_license_platforms(RLM_LICENSE lic);
extern char *			rlm_license_product(RLM_LICENSE lic);
extern int			rlm_license_roaming(RLM_LICENSE lic);
extern char *			rlm_license_server(RLM_LICENSE lic);
extern int 			rlm_license_share(RLM_LICENSE lic);
extern int 			rlm_license_soft_limit(RLM_LICENSE lic);
extern char *			rlm_license_start(RLM_LICENSE lic);
extern int			rlm_license_stat(RLM_LICENSE);
extern int 			rlm_license_type(RLM_LICENSE lic);
extern int 			rlm_license_tz(RLM_LICENSE lic);
extern char * 			rlm_license_ver(RLM_LICENSE lic);

/*
 *	rlm_products() data
 */
extern RLM_PRODUCTS 		rlm_products(RLM_HANDLE, char *, char *);
extern void 			rlm_products_free(RLM_PRODUCTS);
extern void 			rlm_product_first(RLM_PRODUCTS);
extern int 			rlm_product_next(RLM_PRODUCTS);
extern char *			rlm_product_name(RLM_PRODUCTS);
extern char *			rlm_product_exp(RLM_PRODUCTS);
extern char *			rlm_product_ver(RLM_PRODUCTS);
extern int			rlm_product_count(RLM_PRODUCTS);
extern int			rlm_product_current_inuse(RLM_PRODUCTS);
extern int			rlm_product_current_resuse(RLM_PRODUCTS);
extern int			rlm_product_hbased(RLM_PRODUCTS);
extern int			rlm_product_hold(RLM_PRODUCTS);
extern int			rlm_product_max_roam(RLM_PRODUCTS);
extern int			rlm_product_min_remove(RLM_PRODUCTS);
extern int			rlm_product_min_timeout(RLM_PRODUCTS);
extern int			rlm_product_nres(RLM_PRODUCTS);
extern int			rlm_product_num_roam_allowed(RLM_PRODUCTS);
extern int			rlm_product_roaming(RLM_PRODUCTS);
extern int			rlm_product_share(RLM_PRODUCTS);
extern int			rlm_product_soft_limit(RLM_PRODUCTS);
extern int			rlm_product_thisroam(RLM_PRODUCTS);
extern int			rlm_product_timeout(RLM_PRODUCTS);
extern int			rlm_product_tz(RLM_PRODUCTS);
extern int			rlm_product_tokens(RLM_PRODUCTS);
extern int			rlm_product_type(RLM_PRODUCTS);
extern int			rlm_product_ubased(RLM_PRODUCTS);

extern void			rlm_set_active(RLM_HANDLE, int);
extern void			rlm_set_attr_keep_conn(RLM_HANDLE, int);
extern void			rlm_set_environ(RLM_HANDLE, char *, char *, 
									char *);
extern int			rlm_stat(RLM_HANDLE);

/*
 *	rlm_act_xxx() functions - Internet Activation
 */

extern const char * 		rlm_act_errstring(int stat);
extern int			rlm_act_request(RLM_HANDLE rh, const char *url, 
					const char *isv, const char *akey, 
					const char *hostid_list, char *hostname,
					int count, char *extra, char *license);

/*
 *	General Errors - returned by rlm_stat(license_handle)
 */
#define RLM_EH_NOHANDLE		-101	/* No handle supplied to call */
#define RLM_EH_READ_NOLICENSE	-102	/* Can't read license data */
#define RLM_EH_NET_INIT		-103	/* Network (msg_init()) error */
#define RLM_EH_NET_WERR		-104	/* Error writing to network */
#define RLM_EH_NET_RERR		-105	/* Error reading from network */
#define RLM_EH_NET_BADRESP 	-106	/* Unexpected response */
#define RLM_EH_BADHELLO		-107	/* HELLO message for wrong server */

#define RLM_EH_BADPRIVKEY	-108	/* Error in private key */
#define RLM_EH_SIGERROR		-109	/* Error signing authorization */
#define RLM_EH_INTERNAL		-110	/* Internal error */
	
#define RLM_EH_CONN_REFUSED 	-111	/* Connection refused at server */
#define RLM_EH_NOSERVER		-112	/* No server to connect to */
#define RLM_EH_BADHANDSHAKE 	-113	/* Bad communications handshake */
#define RLM_EH_CANTGETETHER 	-114	/* Can't get ethernet address */
					/* system call failures */
#define RLM_EH_MALLOC		-115
#define RLM_EH_BIND		-116	/* bind() error */
#define RLM_EH_SOCKET		-117	/* socket() error */

#define RLM_EH_BADPUBKEY	-118	/* Error in public key */
#define RLM_EH_AUTHFAIL		-119	/* Authentication failed */
#define RLM_EH_WRITE_LF		-120	/* Can't write temp license file */
#define RLM_EH_NO_REPORTLOG 	-121	/* No reportlog file on this server */
#define RLM_EH_DUP_ISV_HID	-122	/* ISV-defined hostid already registered */
#define RLM_EH_BADPARAM		-123	/* Bad parameter passed to RLM function */
#define RLM_EH_ROAMWRITEERR	-124	/* Roam File write error */
#define RLM_EH_ROAMREADERR	-125	/* Roam File read error */
#define RLM_EH_HANDLER_INSTALLED -126	/* heartbeat handler already installed */
#define RLM_EH_CANTCREATLOCK -127	/* Cannot create 'single' lockfile */
#define RLM_EH_CANTOPENLOCK -128	/* Cannot open 'single' lockfile */
#define RLM_EH_CANTSETLOCK -129		/* Cannot set lock on 'single' */
#define RLM_EH_BADRLMLIC -130		/* Bad/missing/expired RLM license */
#define RLM_EH_BADHOST	-131		/* Bad hostname in LF/port@host */
#define RLM_EH_CANTCONNECT_URL -132	/* Cannot connect to specified URL */
#define RLM_EH_OP_NOT_ALLOWED  -133	/* Operation not allowed on server */
#define RLM_EH_ACT_BADSTAT     -134	/* Bad status from activation binary */
#define RLM_EH_ACT_BADLICKEY   -135	/* Bad license key in 
							activation binary */
#define RLM_EH_BAD_HTTP	       -136	/* Bad HTTP transaction */

#define RLM_EH_MAX_ERRS 36

/*
 *	rlm_checkout() errors - returned by rlm_license_stat(license)
 */
#define RLM_EL_NOPRODUCT 	-1	/* No authorization for product */
#define RLM_EL_NOTME		-2	/* Authorization is for another ISV */
#define RLM_EL_EXPIRED		-3	/* Authorization has expired */
#define RLM_EL_NOTTHISHOST 	-4	/* Wrong host for authorization */
#define RLM_EL_BADKEY		-5	/* Bad key in authorization */
#define RLM_EL_BADVER		-6	/* Requested version not supported */
#define RLM_EL_BADDATE		-7	/* bad date format - not permanent or 
								dd-mm-yy */
#define RLM_EL_TOOMANY		-8	/* checkout request for too many 
								licenses */
#define RLM_EL_NOAUTH		-9	/* No license auth supplied to call */
#define RLM_EL_ON_EXC_ALL 	-10	/* On excludeall list */
#define RLM_EL_ON_EXC		-11	/* On feature exclude list */
#define RLM_EL_NOT_INC_ALL 	-12	/* Not on the includeall list */
#define RLM_EL_NOT_INC		-13	/* Not on the feature include list */
#define RLM_EL_OVER_MAX		-14	/* Request would go over license MAX */
#define RLM_EL_REMOVED		-15	/* License (rlm)removed by server */
#define RLM_EL_SERVER_BADRESP 	-16	/* Unexpected response from server */
#define RLM_EL_COMM_ERROR	-17	/* Error communicating with server */
#define RLM_EL_NO_SERV_SUPP	-18	/* License server doesn't support this */
#define RLM_EL_NOHANDLE   	-19	/* No license handle */
#define RLM_EL_SERVER_DOWN  	-20	/* Server closed connection */
#define RLM_EL_NO_HEARTBEAT 	-21	/* No heartbeat response received */
#define RLM_EL_ALLINUSE		-22	/* All licenses in use */
#define RLM_EL_NOHOSTID		-23	/* No hostid on uncounted license */
#define RLM_EL_TIMEDOUT		-24	/* License timed out by server */
#define RLM_EL_INQUEUE		-25	/* In queue for license */
#define RLM_EL_SYNTAX		-26	/* License syntax error */
#define RLM_EL_ROAM_TOOLONG	-27	/* Roam time exceeds maximum */
#define RLM_EL_NO_SERV_HANDLE	-28	/* Server does not know this handle */
#define RLM_EL_ON_EXC_ROAM 	-29	/* On roam exclude list */
#define RLM_EL_NOT_INC_ROAM	-30	/* Not on roam include list */
#define RLM_EL_TOOMANY_ROAMING	-31	/* Too many licenses roaming */
#define RLM_EL_WILL_EXPIRE	-32	/* License expires before roam ends */
#define RLM_EL_ROAMFILEERR	-33	/* Problem with roam file */
#define RLM_EL_RLM_ROAM_ERR	-34	/* Cannot checkout rlm_roam license */
#define RLM_EL_WRONG_PLATFORM	-35	/* Wrong platform for client */
#define RLM_EL_WRONG_TZ		-36	/* Wrong timezone for client */
#define RLM_EL_NOT_STARTED	-37	/* License start date not reached */
#define RLM_EL_CANT_GET_DATE	-38	/* time() failure */
#define RLM_EL_OVERSOFT		-39	/* Over license soft limit */
#define RLM_EL_WINDBACK		-40	/* Clock setback detected */
#define RLM_EL_BADPARAM		-41	/* Bad parameter to checkout() call */
#define RLM_EL_NOROAM_FAILOVER	-42	/* Roam operations not permitted on
					   failover servers */
#define RLM_EL_BADHOST		-43	/* Bad hostname in LF/port@host */
#define RLM_EL_APP_INACTIVE	-44	/* Application is inactive */
#define RLM_EL_NOT_NAMED_USER	-45	/* Not a named user */
#define RLM_EL_TS_DISABLED	-46	/* Terminal Server disabled */

#define RLM_EL_MAX_ERRS 46

/*
 *	Activation errors
 */

#define RLM_ACT_ERR_FIRST	 1001
#define RLM_ACT_BADPARAM	-1001	
#define RLM_ACT_NO_KEY		-1002	
#define RLM_ACT_NO_PROD		-1003		/* No product definition */
#define RLM_ACT_CANT_WRITE_KEYS -1004		/* Can't write keyf table */
#define RLM_ACT_KEY_USED 	-1005		/* Activation key already used*/
#define RLM_ACT_BAD_HOSTID	-1006		/* Missing hostid */
#define RLM_ACT_BAD_HOSTID_TYPE	-1007		/* Invalid hostid type */
#define RLM_ACT_BAD_HTTP	-1008		/* Bad HTTP transaction - 
							UNUSED after v3.0BL4 */
#define RLM_ACT_CANTLOCK	-1009		/* Can't lock activation DB */
#define RLM_ACT_CANTREAD_DB	-1010		/* Can't read activation DB */
#define RLM_ACT_CANT_WRITE_FULFILL -1011	/* Can't write licf table */
#define RLM_ACT_ERR_LAST	11	

#define RLM_ACT_ERR(x) ((x <= -RLM_ACT_ERR_FIRST) && \
			(x > -(RLM_ACT_ERR_FIRST+RLM_ACT_ERR_LAST)))

#ifdef __cplusplus
}
#endif

#endif /* RLM_LICENSE_H_INCLUDED */
