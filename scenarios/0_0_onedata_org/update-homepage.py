#!/usr/bin/env python

import os
import sys
import yaml
import tempfile
import shutil
from subprocess import call as cmd
from subprocess import check_output as output

CFG_FILE = 'homepage-config.yml'
ARTIFACT_PATH = '/artefact'


def print_help():
    print('Usage: {} <option>'.format(sys.argv[0]))
    print('  --help       - display help and exit')
    print('  --docs <id>  - update docs version in {}'.format(CFG_FILE))
    print('  --gui <id>   - update gui version in {}'.format(CFG_FILE))
    print('  --deploy     - deploy docs and gui based on {}'.format(CFG_FILE))
    print('--------------------------------------------------------')
    print('<id> - a docker tag, e.g.: \'onedata/oz-gui-homepage:ID-2563caab9\'')


def print_versions_file_help(versions_file):
    print('Error - expected config file in \'{}\'. It must contain a valid '
          'config, for example:'.format(versions_file))
    print('''--------------------------------------------------------
gui:
    docker: docker.onedata.org/oz-gui-homepage:ID-30e6e688ac
    output-path: /volumes/gui
docs:
    docker: docker.onedata.org/onedata-documentation:ID-fe65d545aa
    output-path: /volumes/docs
--------------------------------------------------------'''.format(
        CFG_FILE))


def ensure_config(versions_file):
    if not os.path.isfile(versions_file):
        print_versions_file_help(versions_file)
        return None

    with open(versions_file, 'r') as stream:
        cfg = yaml.load(stream, Loader=yaml.FullLoader)

    try:
        _ = cfg['gui']['docker']
        _ = cfg['gui']['output-path']
        _ = cfg['docs']['docker']
        _ = cfg['docs']['output-path']
        return cfg
    except Exception:
        print_versions_file_help(versions_file)
        return None


def update_config(versions_file, new_cfg):
    with open(versions_file, "w+") as f:
        yaml.safe_dump(new_cfg, f, default_flow_style=False)


def copy_from_docker(docker, output_path):
    if not os.path.isdir(output_path):
        os.makedirs(output_path)
    cmd(['docker', 'pull', docker])
    out = output(['docker', 'create', '-v', ARTIFACT_PATH, docker, '/bin/true'])
    container = out.rstrip()
    temp_dir = tempfile.mkdtemp()
    cp_dest = os.path.join(temp_dir, 'files')
    cmd(['docker', 'cp', '-L', container + ':' + ARTIFACT_PATH, cp_dest])
    cmd(['docker', 'rm', '-f', container])

    cmd(['chmod', '-R', '+w', output_path])
    cmd(['cp', '-R', os.path.join(cp_dest, '.'), output_path])

    shutil.rmtree(temp_dir)


def main():
    script_dir = os.path.dirname(os.path.realpath(__file__))
    versions_file = os.path.join(script_dir, CFG_FILE)
    cfg = ensure_config(versions_file)
    if cfg:
        if len(sys.argv) == 2 and sys.argv[1] == '--help':
            print_help()

        elif len(sys.argv) == 3 and sys.argv[1] == '--docs':
            docs_docker = sys.argv[2]
            cfg['docs']['docker'] = docs_docker
            update_config(versions_file, cfg)

        elif len(sys.argv) == 3 and sys.argv[1] == '--gui':
            gui_docker = sys.argv[2]
            cfg['gui']['docker'] = gui_docker
            update_config(versions_file, cfg)

        elif len(sys.argv) == 2 and sys.argv[1] == '--deploy':
            gui_output_path = cfg['gui']['output-path']
            gui_docker = cfg['gui']['docker']
            docs_output_path = cfg['docs']['output-path']
            docs_docker = cfg['docs']['docker']
            copy_from_docker(gui_docker, gui_output_path)
            copy_from_docker(docs_docker, docs_output_path)

        else:
            print_help()


if __name__ == "__main__":
    main()
