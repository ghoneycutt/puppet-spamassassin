# Class: spamassassin
#
# This module manages spamassassin
#
class spamassassin {

    package {
        "perl-Encode-Detect":;
        "perl-Geography-Countries":;
        "perl-IP-Country":;
        "perl-Mail-DKIM":;
        "perl-Mail-DomainKeys":;
        "perl-Mail-SPF":;
        "perl-Mail-SPF-Query":;
        "perl-Net-Ident":;
        "spamassassin":;
    } # package

    file {
        "/etc/mail/spamassassin/v312.pre":
            source  => "puppet:///modules/spamassassin/v312.pre",
            require => Package["spamassassin", "perl-Mail-DKIM" ],
            notify  => Service["spamassassin"];
        "/etc/cron.d/sa-update":
            mode    => 600,
            source  => "puppet:///modules/spamassassin/cron.d-sa-update",
            require => Package["spamassassin"];
    } # file

    service { "spamassassin":
        ensure  => running,
        enable  => true,
        require => Package["spamassassin"],
        pattern => "spamd",
    } # service
} # class spamassassin
