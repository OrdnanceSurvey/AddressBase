# AddressBase Core Tiled CSV Processor

### Introduction

AddressBase Core CSV data is now released as a Tiled Supply in CSV files. These files require pre-processing before the data can be used as Full Supply and Change-Only updates in a database. More information on this can be found in the [Getting Started Guide](https://www.ordnancesurvey.co.uk/documents/product-support/getting-started/ab-core-getting-started-guide-v1.0.pdf). The NodeJS script can be used to do this pre-processing and reads the AddressBase Core zipped CSV files and does two things

- Merges the CSV files into a single CSV (and removes the additional header lines)
- Appends a tilename attribute onto the end of each row 

The additional tilename attribute allows the end-user to implement Change-Only updates to your database holding.

### Requirements 

The script uses [NodeJS](https://nodejs.org/en/) to do the pre-processing so this is a requirement for you to have downloaded and installed it. It is an Open Source library however please check with your administrator if you are required to before installing this. As part of the install, you will need to install Node Package Manager [NPM](https://www.npmjs.com/) as the script uses third party modules. Both NodeJS and NPM need to be available in the PATH environment variable so that you can run commands from the Powershell/Command Prompt or a terminal window. During the installation this should be done as default, however, can be tested by opening Powershell/Command Prompt or a terminal window and run

```
node --version
```

And it should display the version of NodeJS installed. If it does not then you will need to manually add them to your PATH environment variable.

### How to use

1. Download or clone this repository to your local machine 
2. Open the index.js file in a text editor and you will need to edit the following line in the script
   ```17.  const sourceDirectory = 'FILE PATH TO FOLDER GOES HERE'``` you will need to set this to the folder where the AddressBase Core zipped CSV files are 
3. Now resave the index.js file
4. The script uses several third party modules from the Node Package Manager [NPM](https://www.npmjs.com/) to read the data, process it, and then save it to a new file. So we need to install these using npm. Open a Powershell/Command Prompt or a terminal window in the folder where the package.json file exists and run the following

    ```
    npm install
    ```
5. Once NPM has installed those additional modules we can now run the script to process the data. So in the same Powershell/Command Prompt or a terminal window run the following command
   
   ```
    node index.js
   ```

The script will display messages in the window as it progresses through reading the AdressBase Core zipped CSV files. If it encounters any errors this will be displayed as well to try and help debug any issues.

The results will be saved inside the *outputs* folder which will also include a log file containing information about the processing for example number of files, the row count, etc which can be used as metadata to confirm the process was successful.

### Issues

If you experience any issues when running this script please raise an issue on this GitHub repo and one of the team will hopefully be able to debug and solve it.

### Licence

This code is made available under the The Open Government Licence (OGL) Version 3 licence.

The additional NPM modules are all MIT licenced.