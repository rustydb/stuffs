#! /usr/bin/python
"""
Copyright:
2014,2015 Cray Inc.; All Rights Reserved.

Description:
ISO packaging application for Cray installation media.

Usage:
    gatherRPMs.py [-p]
    gatherRPMs.py --release-yaml=FILE [-p]

Options:
    -p, --print          Print all packages
    --release-yaml=FILE  Path to the YaML release file.
                         (Defaults to cray_cle_release.yaml) [default: ./cray_cle_release.yaml]
"""
__author__ = 'rbunch'

import yaml
import socket
import os
import re
import shutil
from docopt import docopt

css = "/cray/css/release/cray/build/xt/rpms-master/"
obs_repo = "/srv/obs/repos/"
obs_build = "/srv/obs/build/"


class PackagingException(BaseException):
    def __init__(self, error_msg, command_line_args=None, error_list=None):
        """ The error_list is optional for the most part, but in one case is
            used to pass a list of one or more error messages. When this list
            is specified, the __str__() method turns this into a bulleted
            list in the email that is sent.
        """
        self.error_msg = error_msg
        self.error_list = error_list
        self.command_line_args = command_line_args

    def __str__(self):
        msg_buffer = [self.error_msg, 'Hostname: %s' % (socket.gethostname())]
        if self.command_line_args:
            msg_buffer.append("Command Line Args: %s" % self.command_line_args)
        if self.error_list:
            msg_buffer.append("Error details:")
            for error_item in self.error_list:
                msg_buffer.append('\t- %s' % error_item)
        return '\n'.join(msg_buffer)


class Package(object):
    def __init__(self):

        self.cli_args = docopt(__doc__)
        self.cli_str = str(self.cli_args)

        release_yaml = self.cli_args['--release-yaml']

        if os.path.dirname(release_yaml) == os.getcwd():
            self.release_filename = os.path.basename(release_yaml)
        else:
            self.release_filename = release_yaml

        if release_yaml and os.access(release_yaml, os.R_OK):
            with open(release_yaml, 'r') as fh:

                try:
                    self.yaml = yaml.load(fh)['cray_release'][0]
                    self.repos = self.yaml['repos']
                    self.needed_packages = {}
                    self.release_content_sources = {}
                except KeyError:
                    raise PackagingException(
                        "FATAL:\n\tCannot parse packages in release file [%s].\n\tCLI_ARGS: %s" %
                        (release_yaml, self.cli_str)
                    )

        self.results = {
            'skip': 0,
            'ok': 0,
            'error': 0
        }

    @staticmethod
    def src_package_checker(package):
        if re.search('src', package) is not None:
            return True
        else:
            return False  # FIXME Once we know how we want to handle these we can change this

    def parse_content_sources(self):

        content_source = None
        no_content = []

        for repo in self.repos:

            try:
                for content_source in repo['content_sources']:
                    content_source_path = os.path.join('content_sources', content_source + '.yaml')
                    self.release_content_sources[content_source] = {
                        'path': content_source_path,
                        'arch': repo['arch'],
                        'buildenv': repo['buildenv'],
                        'network': repo['network'],
                        'packages': {}
                    }
            except KeyError:
                if content_source:
                    no_content.append(content_source)
                continue

        print "INFO: Following repos had no content:"
        no_content = list(set(no_content))
        for repo in no_content:
            print "\t%s" % repo

        if self.release_content_sources:
            for content_source in self.release_content_sources:
                with open(self.release_content_sources[content_source]['path'], 'r') as fh:

                    try:
                        content_source_packages = yaml.load(fh)['packages']
                    except KeyError:
                        raise PackagingException("FATAL:\n\tCould not find packages key for: [%s]" % content_source)

                    for package in content_source_packages:
                        self.release_content_sources[content_source]['packages'][package] = \
                            content_source_packages[package]

    def collect_source_packages(self):

        def replace_vars(paths):

            for index, path in enumerate(paths):
                arch = self.release_content_sources[content_source]['arch']
                buildenv = self.release_content_sources[content_source]['buildenv']
                network = self.release_content_sources[content_source]['network']

                # Substitute all the variables within a path with the values given in the original YAML
                path = re.sub('%\(buildenv\)s', buildenv, path)
                path = re.sub('%\(arch\)s', arch, path)
                path = re.sub('%\(network\)s', network, path)
                path = re.sub('%\(BUILDID\)s', 'latest', path)
                paths[index] = path

            return paths

        # For each content source, retrieve the list of packages
        for content_source in self.release_content_sources:
            for package in self.release_content_sources[content_source]['packages']:

                # Dictionary for holding KeyError codes if build and archive keys are not found
                key_errors = {
                    'build': False,
                    'archive': False
                }

                try:
                    build_location = self.release_content_sources[content_source]['packages'][package]['build']
                except KeyError as e:
                    key_errors['build'] = e
                    continue

                if key_errors['build'] is not False and key_errors['archive'] is not False:
                    print "SKIP:\n\t[%s]\n\tErrors:\n\t%s\n\tValue(s):\n\t%s" % \
                          (package, key_errors, self.release_content_sources[content_source]['packages'][package])
                    self.results['skip'] += 1

                # Replace variables in paths
                substituted_vars = replace_vars([build_location])
                build_location = substituted_vars[0]

                # If there is a build, copy that build to css
                # elif not build_location == 'None':
                if not build_location == 'None':

                    # The build_location will be a URL, substitute the appropriate parent directory
                    if re.search('noarch', build_location) is not None:
                        build_info = re.subn('http://download\.buildservice\.us\.cray\.com/', obs_repo,
                                             build_location)
                    else:
                        build_info = re.subn('http://download\.buildservice\.us\.cray\.com/', obs_build,
                                             build_location)

                    # If the substitution failed, the package isn't on OBS and we will skip it for now
                    if build_info[1] == 0:
                        print "SKIP:\n\t[%s] because '%s' is not on OBS." % (package, build_info[0])
                        self.results['skip'] += 1
                        continue

                    else:

                        source = self.find_package(build_info[0], package)

                        if not source:
                            print "ERROR:\n\tSource could not be found for [%s] on OBS.\n\t%s" % \
                                  (package, self.release_content_sources[content_source]['packages'][package])
                            self.results['error'] += 1
                            continue
                        else:
                            self.save_to_css(source)
                else:
                    print "SKIP:\n\tNo source given for [%s]\n\tValue(s): %s" % \
                          (package, self.release_content_sources[content_source]['packages'][package])
                    self.results['skip'] += 1

    def find_package(self, source_path, name):

        # Can not find a package if there isn't a name for it
        if name is None:
            return False

        try:
            os.listdir(source_path)
        except OSError:

            # The URL may have slashes in different places, the colons may need to be modified
            # Attempt to find the package with this updated path
            source_path = re.sub(':/', ':', source_path)

        for root, directories, files in os.walk(source_path):
            for file_name in files:

                # Only scan rpm files
                if re.search('\.rpm$', file_name) is None:
                    continue

                # Handle src packages differently than normal packages
                if not self.src_package_checker(file_name):

                    # Build regex for specific package
                    package = re.compile(name + '-[0-9]+.+')

                    # Return the package path if found
                    if package.match(file_name) is not None:
                        return os.path.join(root, file_name)
                    else:
                        continue
        return False

    def save_to_css(self, source):

        try:
            if os.access(source, os.R_OK) and os.access(css, os.W_OK):
                shutil.copy2(source, css)
                print "OK:\n\tCopy: %s\n\tto: %s" % (source, css)
                self.results['ok'] += 1
                return
        except (IOError, OSError) as e:
            print "ERROR:\n\Copy failure\n\tSource: %s\n\tDestination: %s\n\t%s" % \
                  (source, css, e)
            self.results['error'] += 1
            return

    def print_packages(self):
        for content_source in self.release_content_sources:
            print "YAML: %s" % content_source
            packages = self.release_content_sources[content_source]['packages'].keys()
            packages.sort()
            for package in packages:
                print "\t%s" % package

    def print_results(self):

        ok = self.results['ok']
        skip = self.results['skip']
        error = self.results['error']

        print "Finished with:\n\t  OK(s): %s\n\t SKIP(s): %s\n\tERROR(s): %s" % (ok, skip, error)

    def main(self):
        self.parse_content_sources()

        if self.cli_args['--print']:
            self.print_packages()
            exit(0)

        self.collect_source_packages()
        self.print_results()


if __name__ == "__main__":
    gather = Package()
    gather.main()
