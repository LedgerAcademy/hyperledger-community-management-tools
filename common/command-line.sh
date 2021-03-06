#!/bin/bash

all_specified=FALSE

. ${script_dir}/../common/repositories.sh

# Handle command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    ${INCLUDE_PROJECT_OPTIONS:+--fabric})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${fabric_repositories[@]}" )
        filename+="-fabric"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--sawtooth})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${sawtooth_repositories[@]}" )
        filename+="-sawtooth"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--iroha})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${iroha_repositories[@]}" )
        filename+="-iroha"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--burrow})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${burrow_repositories[@]}" )
        filename+="-burrow"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--indy})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${indy_repositories[@]}" )
        filename+="-indy"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--composer})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${composer_repositories[@]}" )
        filename+="-composer"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--cello})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${cello_repositories[@]}" )
        filename+="-cello"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--explorer})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${explorer_repositories[@]}" )
        filename+="-explorer"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--quilt})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${quilt_repositories[@]}" )
        filename+="-quilt"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--caliper})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${caliper_repositories[@]}" )
        filename+="-caliper"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--ursa})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${ursa_repositories[@]}" )
        filename+="-ursa"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--grid})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${grid_repositories[@]}" )
        filename+="-grid"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--projects})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${project_repositories[@]}" )
        filename+="-projects"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--labs})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${labs_repositories[@]}" )
        filename+="-labs"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--other})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${other_repositories[@]}" )
        filename+="-other"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--gerrit})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${gerrit_repositories[@]}" )
        filename+="-gerrit"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--github})
      if [[ "$all_specified" == FALSE ]] ; then
        repositories+=( "${github_repositories[@]}" )
        filename+="-github"
      fi
    ;;
    ${INCLUDE_PROJECT_OPTIONS:+--all})
      all_specified=TRUE
      filename+="-all"
      repositories="${all_repositories[@]}"
    ;;
    ${INCLUDE_DATE_OPTIONS:+--since})
      since="$2"
      shift # past argument or value. 2nd shift below
      ;;
    ${INCLUDE_DATE_OPTIONS:+--until})
      until="$2"
      shift # past argument or value. 2nd shift below
      ;;
    --output-dir)
      output_dir=$2
      shift # past argument or value. 2nd shift below
    ;;
    --help)
      cat << EOM
        $0 [options]
        ${short_description}

        Options:
EOM
      if [[ -n "$INCLUDE_PROJECT_OPTIONS" ]]
      then
      cat << EOM_PROJECT
          --fabric:   Include Fabric repositories
          --sawtooth: Include Sawtooth repositories
          --iroha:    Include Iroha repositories
          --burrow:   Include Burrow repositories
          --indy:     Include Indy repositories
          --composer: Include Composer repositories
          --cello:    Include Cello repositories
          --explorer: Include Explorer repositories
          --quilt:    Include Quilt repositories
          --caliper:  Include Caliper repositories
          --ursa:     Include Ursa repositories
          --grid:     Include Grid repositories                
          --projects: Include Project repositories
          --labs:     Include Labs repositories
          --other:    Include Other repositories
          --gerrit:   Include Gerrit repositories
          --github:   Include Github repositories
          --all:      Include all repositories (default)
EOM_PROJECT
      fi

      if [[ -n "$INCLUDE_DATE_OPTIONS" ]]
      then
      cat << EOM_DATE
          --since:    Includes commits more recent than this date (mm/dd/yyyy).
                      By default starts from the start of the repo.
          --until:    Includes commits older than this date (mm/dd/yyyy).
                      By default ends at the end of the repo.
EOM_DATE
      fi
      cat << EOM_STD_OPTIONS
          --output-dir <dir>: Where should output be placed. (Default: /tmp)
          --help:     Shows this help message
EOM_STD_OPTIONS

      if [[ -n "$INCLUDE_PROJECT_OPTIONS" ]]
      then
      cat << EOM_NOTES

        NOTE: If no options are specified, it is as if you had specified --all
        NOTE: Multiple repository options can be specified
        NOTE: --all will override all commands for individual projects
EOM_NOTES
      fi
    exit;
    ;;
    *)
      echo "Unknown option $key"
      exit 1
    ;;
esac
shift # past argument or value
done

# if no repositories were specified, then act as if --all was specified
if [ "$repositories" == "" ]
then
  repositories="${all_repositories[@]}"
  filename+="-all"
fi


