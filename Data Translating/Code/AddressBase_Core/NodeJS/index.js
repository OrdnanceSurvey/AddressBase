'use strict'
//Additional NPM modules that are required
const klawSync = require('klaw-sync');
const async = require('async');
const jsonfile = require('jsonfile');
const prettyMs = require('pretty-ms');
const dayjs = require('dayjs');
const appRoot = require('app-root-path');
const fs = require('fs-extra');
const os = require('os');
const StreamZip = require('node-stream-zip');
const readline = require('readline');
const path = require('path');
const chalk = require('chalk');

//Editable variables
const sourceDirectory = 'FILE PATH TO FOLDER GOES HERE'//Enter the full path to the folder of AddressBase Core Zip files. Paths must use / or \\

//Constant Variables
const fileExtension = '.zip'
const outputDirectory = 'outputs'
const outputFilename = 'ABCore'
const cpuCount = os.cpus().length; //We use the cpuCount to multi thread the processing = FASTER
let fileList;
let totalRowCount = 0;
const headerLine = ["UPRN","PARENT_UPRN","UDPRN","USRN","TOID","CLASSIFICATION_CODE","EASTING","NORTHING","LATITUDE","LONGITUDE","RPC","LAST_UPDATE_DATE","SINGLE_LINE_ADDRESS","PO_BOX","ORGANISATION","SUB_BUILDING","BUILDING_NAME","BUILDING_NUMBER","STREET_NAME","LOCALITY","TOWN_NAME","POST_TOWN","ISLAND","POSTCODE","DELIVERY_POINT_SUFFIX","GSS_CODE","CHANGE_CODE","TILENAME"];
let logFile = {};
logFile.fileList = [];

const run = () => {
    const todaysDate = dayjs().format('YYYY-MM-DD');
    const startTime = dayjs();
    console.log(chalk.blue(`Starting to process data on ${todaysDate} at ${startTime}`));
    logFile.startTime = startTime;
    logFile.date = todaysDate;
    logFile.arch = os.arch();
    logFile.hostname = os.hostname();
    logFile.platform = os.platform();
    logFile.release = os.release();
    logFile.username = os.userInfo().username;
    async.series([
        //Function to setup and ensure directories exist before continuing
        function(callback) {
            try {                
                 //Using the FS library to delete the outputs folder in the root of the code directory.
                fs.removeSync(`${appRoot}/${outputDirectory}`) //removes existing outputs directory
                fs.ensureDirSync(`${appRoot}/${outputDirectory}`) //creates new outputs directory
                fs.pathExistsSync(sourceDirectory) //Ensures the sourceDirectory exists
                console.log(chalk.green(`Successfully setup folders`))
                logFile.sourceDirectory = sourceDirectory
                logFile.outputDirectory = outputDirectory
                logFile.outputFilename = `${outputFilename}_${todaysDate}.csv`
            callback()
            } catch (error) {
                console.error(chalk.red(error))
                callback(error)
            }
        },
        //Function to list the files in the sourceDirectory with the correct file extension
        function(callback) {
            const filterFn = item => path.extname(item.path) === fileExtension
            try {
                fileList = klawSync(sourceDirectory, {nodir: true, filter: filterFn})
                if(fileList.length > 0) {
                    console.log(chalk.green(`Number of files found: ${fileList.length}`))
                    logFile.fileCount = fileList.length
                } else {
                    console.error(chalk.red('No files found'))
                    callback('No files found')
                }
            } catch(error) {
                console.error(chalk.red(error))
                callback(error)
            }
            callback()
        },
        //Function use async map limit to multi process the files and write to a new CSV file
        function(callback) {
            let outputFile = fs.createWriteStream(`${appRoot}/${outputDirectory}/${outputFilename}_${todaysDate}.csv`, { flags: 'a', defaultEncoding: 'utf8'})
            outputFile.write(headerLine + '\n')
            async.mapLimit(fileList, cpuCount, function(file, callback) {
                console.log(chalk.magenta(`Processing file: ${path.basename(file.path)}`))
                let tilename = path.basename(file.path, '.zip')
                let fileMetadata = {}
                let fileRowCount = 0;
                fileMetadata.path = file.path
                fileMetadata.tilename = tilename
                fileMetadata.fileName = path.basename(file.path)
                fileMetadata.extenstion = path.extname(file.path)
                const stats = fs.statSync(file.path);
                fileMetadata.size = stats.size/ 1000000.0
                //StreamZip is used to read the data straight from the zip not needing to unzip first
                let zip = new StreamZip({
                    file: file.path,
                    storeEntries: true
                });

                zip.on('ready', () => {
                    for (const entry of Object.values(zip.entries())) {
                        zip.stream(entry.name, (err, stm) => {
                            //ReadLine is used to read the stream (stm) data line by line so we can ignore the header row
                            const rl = readline.createInterface({
                                input: stm
                            });
    
                            rl.on('line', function(line) {
                                //We ignore the HEADER line which contains UPRN
                                if(!line.split(',')[0].includes('UPRN')) { 
                                    //Write to our outputFilename with \n so each line is written on each line
                                    outputFile.write(line + `,${tilename}\n`); 
                                    fileRowCount++
                                    totalRowCount++
                                }
                            })
                            rl.on('close', function() {
                                
                                stm.on('end', function() {
                                    zip.close()
                                });
                                fileMetadata.rowCount = fileRowCount
                                logFile.fileList.push(fileMetadata)
                                callback()
                            })
                        });
                    }
                });
            }, function(error, results) {
                if (error) {
                    console.error(chalk.red(error))
                    callback(error);
                } else {
                    console.log(chalk.green('Finished processing files'))
                    callback();
                }
            });
        }
    ],
    //Function finishes everything and writes the results to a log file
    function(error, result) {
        if(error) {
            console.error(chalk.red(error))
        }
        logFile.totalRows = totalRowCount
        const endTime = dayjs();
        logFile.endTime = endTime
        const timeTaken = endTime - startTime;
        logFile.timeTaken = timeTaken
        const logs = `${appRoot}/${outputDirectory}/log.log`
        jsonfile.writeFile(logs, logFile, { spaces: 2 }, function (error) {
            if (error) {
                console.error(chalk.red(error))
            }
            console.log(chalk.green(`Finished processing in ${prettyMs(timeTaken, {verbose: true})}`));
        })
    });
}

run()