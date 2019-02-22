# Overview
A group of folders for launching different setups of iRODS in docker.
All iRODS deployments use Postgres for the database.

- **jargon**: Installs Jargon (primarily used for testing Jargon against some version of iRODS).
- **just_stand_it_up**: Simply stands up iRODS.
- **old_stuff**: Some old attempts at standing up iRODS (and other things ...).
- **package_building**: Uses iRODS CI tools to stand up iRODS.
- **parallel_tests**: Runs the iRODS test suite in parallel by spreading the tests across multiple containers.
- **topo**: Launches a small iRODS zone.

# Common Info Across Projects
All projects except **topo** will contain a build script called `build_image.sh`.

You can specify what version of iRODS to build by passing in appropriate arguments. They are as follows:
- `--irods-repo`: defaults to `https://github.com/irods/irods`
- `--irods-branch`: defaults to `master`
- `--icommands-repo`: defaults to `https://github.com/irods/irods_client_icommands`
- `--icommands-branch`: defaults to `master`

If you run the build script with no arguments, you'll build the master branch of the `irods/irods` repo as
well as the `irods/irods_client_icommands` repo.

If you want to know how to build the docker image, simply look in the build script.
They are pretty simple scripts.

# parallel_tests & topo
For **parallel_tests**, there are two scripts you must run.
1. `build_image.sh`
2. `run_tests_in_parallel.sh`

**topo** also requires that you run multiple scripts.
1. `create_topo_network.sh` (creates a docker network for the topology)
2. `build_images.sh`
3. `launch_topo.sh`
