# Splunk Add-on for Thinkst Canary

This add-on allows Thinkst Canary customers to retrieve data from the Canary API and to ingest the data into their Splunk environment. Inputs are available for the following data:

- incidents
- devices
- canarytokens
- users
- console audit events

The data collected via the add-on is used to support the Splunk App for Thinkst Canary (<https://splunkbase.splunk.com/app/6196/>).

## Development Overview

The bulk of the add-on was developed with the Splunk Add-on Builder app (<https://splunkbase.splunk.com/app/2962/>).

Splunk Enterprise configuration files that cannot be developed via the Add-on Builder, are available in the "src" directory in the top level of this repo. These files are incorporated into the final build via a shell script that produces the install-ready version of the add-on.

## Development Process

The development process can be broken down into following main steps:

1. Import into the Add-on Builder
2. Developing in the Add-on Builder
   - Configure Data Collection: Creating Python code
   - Manage Source Types
   - Extract Fields
   - Map to Data Models
3. Validate and Package (required)
4. Export Add-on (required)
5. Update out-of-band files (optional)
6. Create Splunkbase package

---
## Import into the Add-on Builder

1. Install the Splunk Add-on Builder app on clean development installation of Splunk Enterprise.
2. Open the Splunk Add-on Builder app, click on "Import Project" and select the latest version of the "TA-thinkst-canary_x_y_z_export.tgz" in the "aob_project" directory of this repo.

---
## Developing in the Add-on Builder

1. Select "Properties" in the add-on panel, and update the "Version" field as appropriate.
2. Click on the add-on panel again and make changes to the add-on as required, using relevant tab in the UI.
    - Configure Data Collection: Creating Python code
    - Manage Source Types
    - Extract Fields
    - Map to Data Models
    - Create Alert Actions

---
##  Validate & Package (required)

This step can be completed from the tab in the Add-on Builder or from the panel displayed in the home view of the Splunk Add-on Builder app.

**Note:** Splunkbase credentials are required for the app validation.
After successfull validation, download the "TA-thinkst-canary-x.y.z.spl" file to a directory (e.g. "Downloads") on the local machine.

## Export Add-on (required)
After successfully validating and packaging the app, export the Add-on Builder project via the panel displayed in the home view of the Splunk Add-on Builder app. A "TA-thinkst-canary_x_y_z_export.tgz" file will be created in the specified directory (e.g. "Downloads") on the local machine.

## Update out-of-band files (optional)
Update Splunk configuration files in the "src" directory of this repo that are not generated by the Add-on Builder.

## Create Splunkbase package
After completing the required steps above create the Splunkbase package by running the "build_macos.sh" script in the "build" directory of the repo. The scripts expects two parameters - the name and location of the Add-on Builder package and the name and location of the exported Add-on Builder project.

```
cd <repo_home>/build
./build_macos.sh <path/to/TA-thinkst-canary-x.y.z.spl> <path/to/TA-thinkst-canary_x_y_z_export.tgz>
```

The script will merge the Add-on Builder pakcage and the additional configuration files into a new package that can be uploaded to Splunkbase. The script places the new package into the root of the repo. The script also copies the project export file to the "aob_project" directory of the repo for future updates and distribution.

**Note:** The script use the GNU version of the "tar" and "sed" utilities and can be installed via Homebrew.

```
brew install gnu-tar
brew install gnu-sed
```
---