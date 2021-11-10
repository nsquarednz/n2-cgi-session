Name: %(echo $PACKAGE)
Version: %(echo $VERSION)
# Release is passed through to our script. We concatenate on the dist flag.
# Dist is a magic variable that will populate our version. I.E. EL8.
Release: %(echo $RELEASE)%{?dist}
Summary: Persistent session data in CGI applications.
Group: Development/Languages/Perl
License: Perl
URL: https://metacpan.org/pod/CGI::Session
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%global _binaries_in_noarch_packages_terminate_build 0

#BuildRequires:
# Define some dependencies that we require in order to use this module.
Requires: perl(CGI) perl(Data::Dumper) perl(Digest::MD5)

%description
N-Squared Software fork of 4.4.x of the Perl CGI Session library.

%post

#
# All build steps are done by build-packages.sh.
#

%prep

#
# All build steps are done by build-packages.sh.
#

%build

#
# All build steps are done by build-packages.sh.
#

%install

rm -rf %{buildroot}
# mkdir -p %{buildroot}/opt/%{name}
# cp -r %{_builddir}/* %{buildroot}/opt/%{name}
cp -r %{_builddir} %{buildroot}
find %{buildroot}

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)

# Include the core files needed to execute the library code.
/usr/local/lib64/perl5/auto/CGI
/usr/local/share/perl5/CGI
# Bundle the CGI man pages.
/usr/local/share/man/man3/CGI::Session.3pm
/usr/local/share/man/man3/CGI::Session::Driver.3pm
/usr/local/share/man/man3/CGI::Session::Driver::DBI.3pm
/usr/local/share/man/man3/CGI::Session::Driver::db_file.3pm
/usr/local/share/man/man3/CGI::Session::Driver::file.3pm
/usr/local/share/man/man3/CGI::Session::Driver::mysql.3pm
/usr/local/share/man/man3/CGI::Session::Driver::postgresql.3pm
/usr/local/share/man/man3/CGI::Session::Driver::sqlite.3pm
/usr/local/share/man/man3/CGI::Session::ErrorHandler.3pm
/usr/local/share/man/man3/CGI::Session::ID::incr.3pm
/usr/local/share/man/man3/CGI::Session::ID::md5.3pm
/usr/local/share/man/man3/CGI::Session::ID::static.3pm
/usr/local/share/man/man3/CGI::Session::Serialize::default.3pm
/usr/local/share/man/man3/CGI::Session::Serialize::freezethaw.3pm
/usr/local/share/man/man3/CGI::Session::Serialize::storable.3pm
/usr/local/share/man/man3/CGI::Session::Test::Default.3pm
/usr/local/share/man/man3/CGI::Session::Tutorial.3pm



%changelog
