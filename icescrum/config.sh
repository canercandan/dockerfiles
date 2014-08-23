#!/bin/sh

echo "Install the config file"

cat > /webapps/config.groovy <<EOF
// Project
icescrum.project.import.enable = true
icescrum.project.export.enable = true
icescrum.project.creation.enable = true
icescrum.project.private.enable = true
icescrum.project.private.default = true

// Users
icescrum.gravatar.secure = true
icescrum.gravatar.enable = true
icescrum.registration.enable = true
icescrum.login.retrieve.enable = true

// Alerts
icescrum.auto_follow_productowner = true
icescrum.auto_follow_stakeholder  = true
icescrum.auto_follow_scrummaster  = true
icescrum.alerts.errors.to = "$ICESCRUM_EMAIL_DEV"
icescrum.alerts.subject_prefix = "[icescrum]"
icescrum.alerts.enable = true
icescrum.alerts.default.from = "$ICESCRUM_EMAIL_WEBMASTER"

// Attachments
icescrum.attachments.enable = true

// Server URL
grails.serverURL = "$ICESCRUM_SERVER_URL"
                   /* Changing the port will require to change 
                     it in the Tomcat server.xml Connector*/

// Logging (for debug purpose)
icescrum.debug.enable = false
icescrum.securitydebug.enable = false

// Working directory
icescrum.baseDir = "$ICESCRUM_BASE_DIR"
                   /* Use a custom directory where Tomcat has write rights
                      (not webapps!!). Path must use '/' (forward slash) */

// Cross-domain (CORS) support for API
icescrum.cors.enable = true  /* CORS is enabled by default
                                However, its enabled only for projects 
                                where web services are enabled */
icescrum.cors.allow.origin.regex = "*"  /* Use double backslash for escaping
                                           e.g. (http://|.+\.)mydomain\.com */

// Mail server (These exemple values arent set by default)
grails.mail.host = "$ICESCRUM_MAIL_HOST"
grails.mail.port = $ICESCRUM_MAIL_PORT
grails.mail.username = "$ICESCRUM_MAIL_USERNAME"
grails.mail.password = "$ICESCRUM_MAIL_PASSWORD"
/*
grails.mail.props = ["mail.smtp.auth":"true",
        "mail.smtp.socketFactory.port":"465",
        "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
        "mail.smtp.socketFactory.fallback":"false"] 
*/
grails.mail.props = $ICESCRUM_MAIL_PROPS
        /* The props are required for SSL connections */

// Database
dataSource.dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
dataSource.driverClassName = "com.mysql.jdbc.Driver"
dataSource.url = "jdbc:mysql://$DB_PORT_3306_TCP_ADDR:$DB_PORT_3306_TCP_PORT/icescrum?useUnicode=true&characterEncoding=utf8"
dataSource.username = "root"
dataSource.password = "$DB_ENV_MYSQL_ROOT_PASSWORD"
EOF
