# CGI::Session

Copy of the latest 4.4.x branch of the Perl CGI Session library associated packaging scripts to generate RPM built packages for RHEL, CentOS and Oracle Linux platforms.

To build an RPM package for a target system the RPM must be build on the target environment that the package will be deployed on as the compilation step happens at build time, one of our Docker build environments is highly recommended.

`cd pkg`
`./build-packages.sh x.x.x x`

Ported Readme Notes:
```
SYNOPSIS
        # Object initialization:
        use CGI::Session;
        $session = CGI::Session->new();

        $CGISESSID = $session->id();

        # send proper HTTP header with cookies:
        print $session->header();

        # storing data in the session
        $session->param('f_name', 'Sherzod');
        # or
        $session->param(-name=>'l_name', -value=>'Ruzmetov');

        # retrieving data
        my $f_name = $session->param('f_name');
        # or
        my $l_name = $session->param(-name=>'l_name');

        # clearing a certain session parameter
        $session->clear(["l_name", "f_name"]);

        # expire '_is_logged_in' flag after 10 idle minutes:
        $session->expire('is_logged_in', '+10m')

        # expire the session itself after 1 idle hour
        $session->expire('+1h');

        # delete the session for good
        $session->delete();

DESCRIPTION
    CGI-Session is a Perl5 library that provides an easy, reliable and modular
    session management system across HTTP requests. Persistency is a key feature
    for such applications as shopping carts, login/authentication routines, and
    application that need to carry data across HTTP requests. CGI::Session does
    that and many more.

COPYRIGHT
    Copyright (C) 2001-2005 Sherzod Ruzmetov <sherzodr@cpan.org>. All rights reserved.
    This library is free software. You can modify and or distribute it under the same
    terms as Perl itself.

AUTHOR
    Sherzod Ruzmetov <sherzodr@cpan.org>

SEE ALSO
    *   CGI::Session::Tutorial - extended CGI::Session manual
    *   RFC 2965 - "HTTP State Management Mechanism" found at
        ftp://ftp.isi.edu/in-notes/rfc2965.txt
    *   CGI - standard CGI library
    *   Apache::Session - another fine alternative to CGI::Session

```
